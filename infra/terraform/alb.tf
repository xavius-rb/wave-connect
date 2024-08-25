resource "aws_alb" "alb" {
  name            = "${var.service_name}-alb"
  security_groups = [aws_security_group.alb.id]
  subnets         = aws_subnet.public.*.id

  tags = {
    Name = "${var.service_name}-alb"
  }
}

resource "aws_alb_listener" "default_http" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.service_target_group.arn
  }
}

#resource "aws_acm_certificate" "alb_cert" {
#  domain_name               = slice(keys(var.domains), 0, 1)[0]
#  subject_alternative_names = keys(var.domains)
#  validation_method         = "DNS"
#  key_algorithm             = "EC_secp384r1"

#  tags = var.tags

#  lifecycle {
#    create_before_destroy = true
#  }
#}


#resource "aws_alb_listener" "alb_default_listener_https" {
#  load_balancer_arn = aws_alb.alb.arn
  #port              = 443
  #protocol          = "HTTPS"
  #certificate_arn   = aws_acm_certificate.alb_certificate.arn
  #ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"

 #default_action {
    #type = "fixed-response"
    #target_group_arn = aws_alb_target_group.service_target_group.arn

    #fixed_response {
    #  content_type = "text/plain"
    #  message_body = "Access denied"
    #  status_code  = "403"
    #}
  #}

  #depends_on = [aws_acm_certificate.alb_certificate]
#}

resource "aws_alb_listener_rule" "https_listener_rule" {
  listener_arn = aws_alb_listener.default_http.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.service_target_group.arn
  }

  condition {
    host_header {
      values = ["*.${var.service_name}"]
    }
  }

  condition {
    http_header {
      http_header_name = "X-Custom-Header"
      values           = [var.service_name]
    }
  }
}

resource "aws_alb_target_group" "service_target_group" {
  name                 = "${var.service_name}-TargetGroup1"
  port                 = var.container_port
  protocol             = "HTTP"
  vpc_id               = aws_vpc.default.id
  deregistration_delay = 5
  target_type          = "ip"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 60
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 30
  }

  depends_on = [aws_alb.alb]
}