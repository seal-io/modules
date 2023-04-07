resource "random_string" "password" {
  length = 16
}

resource "helm_release" "mysql" {
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mysql"

  create_namespace = true
  namespace        = local.namespace
  name             = local.name

  set {
    name  = "fullnameOverride"
    value = local.name
  }
  set {
    name  = "auth.database"
    value = var.database
  }
  set {
    name  = "auth.username"
    value = var.username
  }
  set {
    name  = "auth.password"
    value = coalesce(var.password, random_string.password.result)
  }
  set {
    name  = "initdbScripts.init_script\\.sql"
    value = var.init_db_script
  }
}

data "kubernetes_service" "mysql_service" {
  depends_on = [helm_release.mysql]
  metadata {
    name      = local.name
    namespace = local.namespace
  }
}

locals {
  name      = "${var.seal_metadata_module_name}-mysql"
  namespace = coalesce(var.namespace, "${var.seal_metadata_project_name}-${var.seal_metadata_application_name}-${var.seal_metadata_application_instance_name}")
}