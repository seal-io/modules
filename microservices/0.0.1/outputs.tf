output "frontend_external_endpoint" {
    description = "Online Boutique frontend access URL" 
    value       = "http://${data.kubernetes_service.frontend_service.status.loadBalancer.0.ingress.0.hostname}:${data.kubernetes_service.frontend_service.spec.ports.0.nodePort}"
}
