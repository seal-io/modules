resource "helm_release" "mysql" {
  name = "mysql-${random_pet.name_suffix.id}"
  namespace = var.namespace

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mysql"

  set {
    name  = "auth.database"
    value = var.database
  }
  set {
    name  = "auth.username"
    value = coalesce(var.username, "mysql")
  }
  set {
    name  = "auth.password"
    value = coalesce( var.password , random_string.password.result)
  }
  set {
    name  = "initdbScripts.init_script\\.sql"
    value = var.init_db_script != null && var.init_db_script != "" ? var.init_db_script : ""
  }
}

resource "random_string" "password" {
  length           = 16
}

resource "random_pet" "name_suffix" {}

data "kubernetes_service" "mysql_service" {
  depends_on = [helm_release.mysql]
  metadata {
    name = "mysql-${random_pet.name_suffix.id}"
    namespace = var.namespace
  }
}