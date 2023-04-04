terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

resource "kubectl_manifest" "ns" {
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: ${local.namespace}
YAML
}

module "deployment" {
  depends_on = [resource.kubectl_manifest.ns]

  source  = "terraform-iaac/deployment/kubernetes"
  version = "1.4.2"

  name      = local.name
  namespace = local.namespace
  image     = var.image
  resources = {
    request_cpu    = var.request_cpu == "" ? null : var.request_cpu
    limit_cpu      = var.limit_cpu == "" ? null : var.limit_cpu
    request_memory = var.request_memory == "" ? null : var.request_memory
    limit_memory   = var.limit_memory == "" ? null : var.limit_memory
  }
  env = var.env

  wait_for_rollout = false
}

module "service" {
  depends_on = [resource.kubectl_manifest.ns]

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

locals {
  name      = coalesce(var.name, "${var.seal_metadata_application_name}-${var.seal_metadata_application_instance_name}-${var.seal_metadata_module_name}")
  namespace = coalesce(var.namespace, "${var.seal_metadata_project_name}-${var.seal_metadata_application_name}-${var.seal_metadata_application_instance_name}")
}
