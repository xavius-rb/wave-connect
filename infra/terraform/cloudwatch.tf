resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/${var.service_name}"
  retention_in_days = 5

  tags = {
    Name = "${var.service_name}-log-group"
  }
}