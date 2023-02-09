resource "helm_release" "mysql" {
  name = var.name
  namespace = var.namespace

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mysql"

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
    value = var.password
  }
  set {
    name  = "initdbScripts.init_script\\.sql"
    value = var.init_db_script
  }
}

data "kubernetes_service" "mysql_service" {
  depends_on = [helm_release.mysql]
  metadata {
    name = "${var.name}-mysql"
    namespace = var.namespace
  }
}