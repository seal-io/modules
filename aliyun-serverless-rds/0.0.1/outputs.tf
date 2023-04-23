output "example_db_database_name" {
  description = "Rds database id."
  value       = module.databases.example_database_name
}

output "example_db_database_account" {
  description = "Rds database account."
  value       = module.databases.example_database_account
}

output "example_db_instance_connection_string" {
  description = "Rds instance public connection string"
  value       = concat(alicloud_db_instance.example.*.connection_string, [""])[0]
}

