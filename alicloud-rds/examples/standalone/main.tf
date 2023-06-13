terraform {
  required_version = ">= 1.0"

  required_providers {
    byteset = {
      source = "seal-io/byteset"
    }
  }
}

provider "alicloud" {
}

provider "byteset" {
}

variable "with_mysql" {
  type    = bool
  default = false
}

variable "with_postgres" {
  type    = bool
  default = false
}

resource "random_string" "password" {
  length  = 16
  special = false
}

########
# MySQL
########

module "mysql" {
  count = var.with_mysql ? 1 : 0

  source = "../../0.0.1"

  engine       = "MySQL-8.0"
  architecture = "Standalone"
  password     = random_string.password.result

  init_sql_url = "https://raw.githubusercontent.com/seal-io/terraform-provider-byteset/main/byteset/testdata/mysql-lg.sql"

  seal_metadata_service_name = "mysql"
}

output "mysql_db_endpoint" {
  value = try(module.mysql.0.db_endpoint, null)
}

output "mysql_db_host" {
  value = try(module.mysql.0.db_host, null)
}

output "mysql_db_driver" {
  value = try(module.mysql.0.db_driver, null)
}

output "mysql_db_port" {
  value = try(module.mysql.0.db_port, null)
}

output "mysql_db_name" {
  value = try(module.mysql.0.db_name, null)
}

output "mysql_db_username" {
  value = try(module.mysql.0.db_username, null)
}

output "mysql_db_password" {
  sensitive = true
  value     = try(module.mysql.0.db_password, null)
}

#############
# PostgreSQL
#############

module "postgres" {
  count = var.with_postgres ? 1 : 0

  source = "../../0.0.1"

  engine       = "PostgreSQL-13"
  architecture = "Standalone"
  password     = random_string.password.result

  init_sql_url = "https://raw.githubusercontent.com/seal-io/terraform-provider-byteset/main/byteset/testdata/postgres.sql"

  seal_metadata_service_name = "postgres"
}

output "postgres_db_endpoint" {
  value = try(module.postgres.0.db_endpoint, null)
}

output "postgres_db_host" {
  value = try(module.postgres.db_host, null)
}

output "postgres_db_driver" {
  value = try(module.postgres.0.db_driver, null)
}

output "postgres_db_port" {
  value = try(module.postgres.0.db_port, null)
}

output "postgres_db_name" {
  value = try(module.postgres.0.db_name, null)
}

output "postgres_db_username" {
  value = try(module.postgres.0.db_username, null)
}

output "postgres_db_password" {
  sensitive = true
  value     = try(module.postgres.0.db_password, null)
}
