output "frontend_external_endpoint" {
    description = "Online Boutique frontend access URL" 
    value       = "http://${data.kubernetes_service.frontend_service.metadata.0.spec.external_ips}:${data.kubernetes_service.frontend_service.metadata.0.port.0.node_port}"
}
