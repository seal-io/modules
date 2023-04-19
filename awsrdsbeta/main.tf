variable "db_name" {
  description = "Name of the database to be created"
}

variable "db_username" {
  description = "Username for the database"
}

variable "db_password" {
  description = "Password for the database"
}

variable "db_instance_class" {
  description = "Instance class for the RDS instance"
  default     = "db.t2.micro"
}

variable "db_engine" {
  description = "Database engine to be used"
  default     = "mysql"
}

variable "db_engine_version" {
  description = "Version of the database engine to be used"
  default     = "5.7"
}

variable "db_allocated_storage" {
  description = "Allocated storage for the RDS instance"
  default     = 10
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group"
}

variable "db_security_group_ids" {
  description = "List of security group IDs to be associated with the RDS instance"
}

variable "db_parameter_group_name" {
  description = "Name of the DB parameter group"
}

variable "db_backup_retention_period" {
  description = "Number of days to retain backups for"
  default     = 7
}

variable "db_multi_az" {
  description = "Enable multi-AZ deployment"
  default     = false
}

variable "db_tags" {
  description = "Map of tags to be applied to the RDS instance"
  default     = {}
}

resource "aws_db_instance" "rds_instance" {
  allocated_storage    = var.db_allocated_storage
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = var.db_subnet_group_name
  vpc_security_group_ids = var.db_security_group_ids
  db_parameter_group_name = var.db_parameter_group_name
  backup_retention_period = var.db_backup_retention_period
  multi_az             = var.db_multi_az
  tags                 = var.db_tags
}

output "db_instance_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}

output "db_instance_username" {
  value = aws_db_instance.rds_instance.username
}

output "db_instance_password" {
  value = aws_db_instance.rds_instance.password
}