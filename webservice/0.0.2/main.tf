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

data "kubernetes_resources" "nodes" {
  api_version    = "v1"
  kind           = "Node"
  label_selector = "kubernetes.io/os=linux"
}

locals {
  node_addresses = flatten([for val in data.kubernetes_resources.nodes.objects :
    val["status"]["addresses"]
  ])
  node_external_ips = [for val in local.node_addresses :
    val["address"] if val["type"] == "ExternalIP"
  ]
  node_internal_ips = [for val in local.node_addresses :
    val["address"] if val["type"] == "InternalIP"
  ]
  node_ip = length(local.node_external_ips) != 0 ? local.node_external_ips[0] : length(local.node_internal_ips) != 0 ? local.node_internal_ips[0] : null
}

locals {
  name      = coalesce(var.name, "${var.seal_metadata_module_name}")
  namespace = coalesce(var.namespace, "${var.seal_metadata_project_name}-${var.seal_metadata_application_name}-${var.seal_metadata_application_instance_name}")
}
