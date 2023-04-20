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

data "kubectl_path_documents" "manifest" {
  pattern    = "./online-boutique-manifests.yaml"
  var        = {
    namespace        = local.namespace
    image_registry   = var.image_registry
    image_repository = var.image_repository
  }
}

resource "kubectl_manifest" "manifest" {
  depends_on = [kubectl_manifest.namespace]

  for_each  = toset(data.kubectl_path_documents.manifest.documents)
  yaml_body = each.value
}

data "kubernetes_service" "frontend-external" {
  depends_on = [kubectl_manifest.manifest]

  metadata {
    name      = frontend-external
    namespace = local.namespace
  }
}

locals {
  name      = coalesce(var.name, "${var.seal_metadata_module_name}")
  namespace = coalesce(var.namespace, "${var.seal_metadata_project_name}-${var.seal_metadata_application_name}-${var.seal_metadata_application_instance_name}")
}
