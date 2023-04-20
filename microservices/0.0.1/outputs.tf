output "frontend_external_endpoint" {
    description = "Online Boutique frontend access URL" 
    value       = "http://${tolist(data.kubernetes_service.frontend_service.spec.0.external_ips)[0]}:${data.kubernetes_service.frontend_service.port.node_port}"
}
