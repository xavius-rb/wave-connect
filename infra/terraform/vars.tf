variable "aws_region" {
  description = "AWS region"
  default     = "ap-southeast-2"
  type        = string
}

variable "service_name" {
  description = "A Docker image-compatible name for the service"
  default     = "demo"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC network"
  default     = "10.1.0.0/16"
  type        = string
}

variable "cpu_units" {
  description = "CPU units for the ECS task"
  default     = 256
  type        = number
}

variable "memory" {
  description = "Memory for the ECS task"
  default     = 512
  type        = number
}

variable "container_port" {
  description = "Port for the container"
  default     = 3000
  type        = number
}