output "frontend_external_endpoint" {
    description = "Access URL" 
    value       = "http://${data.kubernetes_service.service.status.load_balancer.0.ingress.0.hostname}:${data.kubernetes_service.service.spec.ports.0.node_port}"
}
