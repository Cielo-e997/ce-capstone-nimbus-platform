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
output "vpc_id" {
  description = "ID of the main VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.networking.public_subnet_ids
}

output "private_app_subnet_ids" {
  description = "IDs of the private application subnets"
  value       = module.networking.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  description = "IDs of the private database subnets"
  value       = module.networking.private_db_subnet_ids
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = module.networking.internet_gateway_id
}

output "nat_gateway_id" {
  description = "ID of the NAT gateway"
  value       = module.networking.nat_gateway_id
}
