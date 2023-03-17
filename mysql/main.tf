resource "random_pet" "namespace" {}
resource "random_pet" "name_suffix" {}
resource "random_string" "password" {
  length           = 16
}

resource "helm_release" "mysql" {
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mysql"

  create_namespace = true
  namespace = coalesce(var.namespace, random_pet.namespace.id)
  name = "mysql-${random_pet.name_suffix.id}"

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
    value = coalesce( var.password , random_string.password.result)
  }
  set {
    name  = "initdbScripts.init_script\\.sql"
    value = var.init_db_script
  }
}

data "kubernetes_service" "mysql_service" {
  depends_on = [helm_release.mysql]
  metadata {
    name = "mysql-${random_pet.name_suffix.id}"
    namespace = coalesce(var.namespace, random_pet.namespace.id)
  }
}
