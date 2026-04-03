variable "private_db_subnet_ids" {
  description = "Private DB subnet IDs"
  type        = list(string)
}

variable "db_security_group_id" {
  description = "Database security group ID"
  type        = string
}
