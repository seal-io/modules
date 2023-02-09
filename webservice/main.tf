module "deployment" {
  source  = "terraform-iaac/deployment/kubernetes"
  version = "1.4.2"

  name      = var.name
  namespace = var.namespace
  image     = var.image
  resources = {
    request_cpu = var.cpu
    limit_cpu = var.cpu
    request_memory = var.memory
    limit_memory = var.memory
  }
  env = var.env
}

module "service" {
  source  = "terraform-iaac/service/kubernetes"
  version = "1.0.4"

  app_name      = var.name
  app_namespace = var.namespace
  port_mapping     = [for p in var.port :
  {
    name          = "port-${p}"
    internal_port = p
    external_port = p
    protocol      = "TCP"
  }]
}
