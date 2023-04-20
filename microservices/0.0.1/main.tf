terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

resource "kubectl_manifest" "namespace" {
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: ${local.namespace}
YAML
}

data "kubectl_flie_documents" "docs" {
  content    = file("online-boutique-manifests.yaml")
  vars       = {
    namespace        = local.namespace
    image_registry   = var.image_registry
    image_repository = var.image_repository
  }
}

resource "kubectl_manifest" "manifest" {
  depends_on = [kubectl_manifest.namespace]

  for_each  = toset(data.kubectl_file_documents.docs.manifests)
  yaml_body = each.value
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
