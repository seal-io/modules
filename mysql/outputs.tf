output "database_ip" {
  value = data.kubernetes_service.mysql_service.spec.0.cluster_ip
}
