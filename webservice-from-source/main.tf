terraform {
  required_providers {
    kaniko = {
      source = "gitlawr/kaniko"
      version = "0.0.1-dev1"
    }
  }
}

resource "kaniko_image" "image" {
  # Only handle git context. Explicitly use the git scheme.
  context = replace(var.git_url,"https://","git://")
  dockerfile = var.dockerfile
  destination = var.image

  git_username = var.git_auth ? var.git_username : ""
  git_password = var.git_auth ? var.git_password : ""
  registry_username = var.registry_auth ? var.registry_username : ""
  registry_password = var.registry_auth ? var.registry_password : ""
}

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

  depends_on = [kaniko_image.image]
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

  depends_on = [kaniko_image.image]
}

data "kubernetes_service" "service" {
  depends_on = [module.service]
  metadata {
    name = var.name
    namespace = var.namespace
  }
}
