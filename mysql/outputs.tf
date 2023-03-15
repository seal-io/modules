output "db_host" {
  value = data.kubernetes_service.mysql_service.spec.0.cluster_ip
}

output "db_name" {
  value = var.database
}

output "db_username" {
  value = var.username
}

output "db_password" {
  value = coalesce( var.password , random_string.password.result)
}