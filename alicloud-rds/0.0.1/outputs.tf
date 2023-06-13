output "db_endpoint" {
  value = local.endpoint
}

output "db_host" {
  value = local.host
}

output "db_endpoint_replica" {
  value = local.endpoint_replica
}

output "db_host_replica" {
  value = local.host_replica
}

output "db_driver" {
  value = local.driver
}

output "db_port" {
  value = local.port
}

output "db_name" {
  value = local.database
}

output "db_username" {
  value = local.username
}

output "db_password" {
  sensitive = true
  value     = local.password
}
