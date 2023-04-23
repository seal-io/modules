variable "db_name" {
  type        = string
  description = "The name of the database"
  default     = "mydb"
}

variable "db_username" {
  type        = string
  description = "The username for the database"
  default     = "admin"
}

variable "db_password" {
  type        = string
  description = "The password for the database"
  default     = "password123"
}

resource "alicloud_db_instance" "rds" {
  engine               = "MySQL"
  engine_version       = "5.7"
  instance_type        = "rds.mysql.s1.small"
  instance_storage     = 20
  instance_name        = "my-rds-instance"
  security_ips         = ["0.0.0.0/0"]
  vswitch_id           = "vsw-123456"
  private_ip_address   = "192.168.0.10"
  db_name              = var.db_name
  db_instance_class    = "mysql.n1.micro"
  db_instance_storage  = 20
  db_account_name      = var.db_username
  db_account_password  = var.db_password
}

output "db_endpoint" {
  value = alicloud_db_instance.rds.endpoint
}

output "db_username" {
  value = var.db_username
}

output "db_password" {
  value = var.db_password
}