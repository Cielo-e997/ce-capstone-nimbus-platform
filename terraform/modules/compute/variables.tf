variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where compute resources will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the load balancer"
  type        = list(string)
}

variable "private_app_subnet_ids" {
  description = "Private subnet IDs for the application instances"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID for the load balancer"
  type        = string
}

variable "app_security_group_id" {
  description = "Security group ID for the application instances"
  type        = string
}

variable "db_endpoint" {
  description = "RDS endpoint passed to the application"
  type        = string
}

variable "app_port" {
  description = "Port exposed by the application"
  type        = number
  default     = 5000
}

variable "instance_type" {
  description = "EC2 instance type for the application tier"
  type        = string
  default     = "t3.micro"
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
  default     = 4
}
