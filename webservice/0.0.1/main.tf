resource "random_pet" "namespace" {}
resource "random_pet" "name" {}

resource "kubernetes_namespace" "ns" {
  count = var.create_namespace == true ? 1 : 0

  metadata {
    name   = coalesce(var.namespace, random_pet.namespace.id)
  }
}

module "deployment" {
  source  = "terraform-iaac/deployment/kubernetes"
  version = "1.4.2"

  name      = coalesce(var.name, random_pet.name.id)
  namespace = coalesce(var.namespace, random_pet.namespace.id)
  image     = var.image
  resources = {
    request_cpu = var.cpu
    limit_cpu = var.cpu
    request_memory = var.memory
    limit_memory = var.memory
  }
  env = var.env
  depends_on = [resource.kubernetes_namespace.ns]
}

module "service" {
  source  = "terraform-iaac/service/kubernetes"
  version = "1.0.4"

  app_name      = coalesce(var.name, random_pet.name.id)
  app_namespace = coalesce(var.namespace, random_pet.namespace.id)
  type          = "NodePort"
  port_mapping     = [for p in var.ports :
  {
    name          = "port-${p}"
    internal_port = p
    external_port = p
    protocol      = "TCP"
  }]
  depends_on = [resource.kubernetes_namespace.ns]
}

data "kubernetes_service" "service" {
  depends_on = [module.service]
  metadata {
    name = coalesce(var.name, random_pet.name.id)
    namespace = coalesce(var.namespace, random_pet.namespace.id)
  }
}
