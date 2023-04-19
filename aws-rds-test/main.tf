variable "db_name" {
  description = "Name of the database"
}

variable "db_engine" {
  description = "Database engine type"
}

variable "db_engine_version" {
  description = "Database engine version"
}

variable "db_instance_class" {
  description = "Instance class of the database"
  default = "default"
}

variable "db_username" {
  description = "Username for the database"
}

variable "db_password" {
  description = "Password for the database"
}

variable "db_subnet_group_name" {
  description = "Name of the subnet group for the database"
}

variable "db_security_groups" {
  description = "List of security groups to associate with the database"
  type        = list(string)
}

variable "db_parameter_group_name" {
  description = "Name of the parameter group for the database"
}

variable "db_allocated_storage" {
  description = "Amount of storage to allocate for the database, in GB"
}

variable "db_backup_retention_period" {
  description = "Number of days to retain backups for the database"
}

variable "db_multi_az" {
  description = "Whether to enable multi-AZ deployment for the database"
  type        = bool
}

variable "db_tags" {
  description = "Map of tags to apply to the database"
  type        = map(string)
}

output "db_username" {
  description = "Username for the database"
  value       = aws_db_instance.example.username
}

output "db_password" {
  description = "Password for the database"
  value       = aws_db_instance.example.password
}

output "db_endpoint" {
  description = "Endpoint for the database"
  value       = aws_db_instance.example.endpoint
}

resource "aws_db_subnet_group" "example" {
  name        = var.db_subnet_group_name
  subnet_ids  = var.db_subnet_ids
  tags        = var.db_tags
}

resource "aws_db_instance" "example" {
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  subnet_group_name    = aws_db_subnet_group.example.name
  vpc_security_group_ids = var.db_security_groups
  parameter_group_name = var.db_parameter_group_name
  allocated_storage    = var.db_allocated_storage
  backup_retention_period = var.db_backup_retention_period
  multi_az             = var.db_multi_az
  tags                 = var.db_tags
}