resource "aws_ecs_cluster" "default" {
  name = "${var.service_name}-ecsCluster"

  tags = {
    Name = "${var.service_name}-ecs-cluster"
  }
}