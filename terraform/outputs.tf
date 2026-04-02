output "aws_region" {
  description = "AWS region used for this deployment"
  value       = var.aws_region
}

output "project_name" {
  description = "Project name"
  value       = var.project_name
}

output "environment" {
  description = "Deployment environment"
  value       = var.environment
}

output "common_name_prefix" {
  description = "Common prefix used for resource naming"
  value       = local.common_name_prefix
}
