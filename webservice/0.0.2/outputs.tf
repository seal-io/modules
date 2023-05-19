output "service_ip" {
  description = "Service IP"
  value       = data.kubernetes_service.service.spec.0.cluster_ip
}

output "ports" {
  description = "Service Ports"
  value       = var.ports
}

output "endpoints" {
  value = local.node_ip != null ? tolist([for p in data.kubernetes_service.service.spec.0.port :
    "${local.node_ip}:${p.node_port}"
  ]) : null
}
