terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

variable "host" {
  type = string
}

variable "client_certificate" {
  type = string
}

variable "client_key" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

provider "kubernetes" {
  host = var.host

  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

resource "kubectl_manifest" "namespace" {
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: ${local.namespace}
YAML
}

data "kubectl_path_documents" "manifest" {
  pattern = "./online-boutique-manifests.yaml"
  vars = {
    namespace        = local.namespace 
    image_registry   = var.image_registry
    image_repository = var.image_repository
  }
}

resource "kubectl_manifest" "manifest" {
  depends_on = [kubectl_manifest.namespace]

  count     = length(data.kubectl_path_documents.manifest.documents)
  yaml_body = element(data.kubectl_path_documents.manifest.documents, count.index)
  #for_each  = toset(data.kubectl_path_documents.manifest.manifests)
  #yaml_body = each.value
}

data "kubernetes_service" "service" {
  depends_on = [kubectl_manifest.manifest]

  metadata {
    name      = local.frontend_service_name
    namespace = local.namespace
  }
}

locals {
  frontend_service_name = var.frontend_service_name
  namespace             = coalesce(var.namespace, "${var.seal_metadata_project_name}-${var.seal_metadata_application_name}-${var.seal_metadata_application_instance_name}")
}
