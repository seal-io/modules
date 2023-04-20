output "frontend_external_endpoint" {
    description = "Online Boutique frontend access URL" 
    value       = "http://${data.kubernetes_service.frontend_service.spec.external_ips}"
}
