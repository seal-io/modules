output "frontend_external_endpoint" {
    value = "http://${data.kubernetes_service.frontend_external.status.loadBalancer.0.ingress.0.hostname}"
}
