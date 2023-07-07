terraform {
  required_providers {
    kaniko = {
      source  = "seal-io/kaniko"
      version = "0.0.1"
    }
  }
}

#######
# Build
#######

resource "kaniko_image" "image" {
  # Only handle git context. Explicitly use the git scheme.
  context     = replace(var.git_url, "https://", "git://")
  dockerfile  = var.dockerfile
  destination = var.image

  git_username      = var.git_auth ? var.git_username : ""
  git_password      = var.git_auth ? var.git_password : ""
  registry_username = var.registry_auth ? var.registry_username : ""
  registry_password = var.registry_auth ? var.registry_password : ""
}

########
# Deploy 
########

module "deployment" {
  depends_on = [resource.kaniko_image.image]

  # disable wait for all pods be ready.
  #
  wait_for_rollout = false

  source  = "terraform-iaac/deployment/kubernetes"
  version = "1.4.2"

  name      = local.name
  namespace = local.namespace
  image     = var.image
  replicas  = var.replicas
  resources = {
    request_cpu    = var.request_cpu == "" ? null : var.request_cpu
    limit_cpu      = var.limit_cpu == "" ? null : var.limit_cpu
    request_memory = var.request_memory == "" ? null : var.request_memory
    limit_memory   = var.limit_memory == "" ? null : var.limit_memory
  }
  env = var.env
}

module "service" {
  depends_on = [resource.kaniko_image.image]

  source  = "terraform-iaac/service/kubernetes"
  version = "1.0.4"

  app_name      = local.name
  app_namespace = local.namespace
  type          = "NodePort"
  port_mapping = [for p in var.ports :
    {
      name          = "port-${p}"
      internal_port = p
      external_port = p
      protocol      = "TCP"
  }]
}

data "kubernetes_service" "service" {
  depends_on = [module.service]

  metadata {
    name      = local.name
    namespace = local.namespace
  }
}

########
# Common
########

locals {
  name      = coalesce(var.name, "${var.seal_metadata_service_name}")
  namespace = coalesce(var.namespace, var.seal_metadata_namespace_name)
}
