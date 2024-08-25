resource "aws_ecs_task_definition" "default" {
  family                   = "${var.service_name}_ecsTaskDefinition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.cpu_units
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name         = "${var.service_name}-web"
      #image        = "${aws_ecr_repository.ecr.repository_url}:${var.hash}"
      image        = "public.ecr.aws/o5f9c6a7/docker-getting-started:latest" # Replace with your own image
      cpu          = var.cpu_units
      memory       = var.memory
      essential    = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          "awslogs-group"         = aws_cloudwatch_log_group.log_group.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "${var.service_name}-log-stream"
        }
      }
    }
  ])

  tags = {
    Name  = "${var.service_name}-ecs-web-task-def"
  }
}