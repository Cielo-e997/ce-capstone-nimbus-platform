variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "nimbus"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}
