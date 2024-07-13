resource "aws_ecs_service" "service" {
  name                               = "${var.service_name}_ecsService"
  cluster                            = aws_ecs_cluster.default.id
  task_definition                    = aws_ecs_task_definition.default.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 100
  launch_type                        = "FARGATE"

  load_balancer {
    target_group_arn = aws_alb_target_group.service_target_group.arn
    container_name   = "${var.service_name}-web"
    container_port   = var.container_port
  }

  network_configuration {
    security_groups  = [aws_security_group.ecs_container_instance.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }
}