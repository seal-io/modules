#
# Constants.
#
locals {
  engineInfos = tomap({
    #
    # MySQL.
    #

    "MySQL-5.7" : {
      "driver" : "mysql",
      "port" : 3306,
      "chart" : "mysql",
      "repository" : "bitnami/mysql",
      "tag" : "5.7"
    },
    "MySQL-8.0" : {
      "driver" : "mysql",
      "port" : 3306,
      "chart" : "mysql",
      "repository" : "bitnami/mysql",
      "tag" : "8.0"
    },

    #
    # MariaDB.
    #

    "MariaDB-10.3" : {
      "driver" : "mariadb",
      "port" : 3306,
      "chart" : "mariadb",
      "repository" : "bitnami/mariadb",
      "tag" : "10.3"
    },
    "MariaDB-10.4" : {
      "driver" : "mariadb",
      "port" : 3306,
      "chart" : "mariadb",
      "repository" : "bitnami/mariadb",
      "tag" : "10.4"
    },
    "MariaDB-10.5" : {
      "driver" : "mariadb",
      "port" : 3306,
      "chart" : "mariadb",
      "repository" : "bitnami/mariadb",
      "tag" : "10.5"
    },
    "MariaDB-10.6" : {
      "driver" : "mariadb",
      "port" : 3306,
      "chart" : "mariadb",
      "repository" : "bitnami/mariadb",
      "tag" : "10.6"
    },

    #
    # PostgreSQL.
    #

    "PostgreSQL-13" : {
      "driver" : "postgresql",
      "port" : 5432,
      "chart" : "postgresql",
      "repository" : "bitnami/postgresql",
      "tag" : "13"
    },
    "PostgreSQL-14" : {
      "driver" : "postgresql",
      "port" : 5432,
      "chart" : "postgresql",
      "repository" : "bitnami/postgresql",
      "tag" : "14"
    },
    "PostgreSQL-15" : {
      "driver" : "postgresql",
      "port" : 5432,
      "chart" : "postgresql",
      "repository" : "bitnami/postgresql",
      "tag" : "15"
    },

  })
}

#
# Prepare locals.
#

locals {
  seal_metadata_project_name     = coalesce(var.seal_metadata_project_name, "example")
  seal_metadata_environment_name = coalesce(var.seal_metadata_environment_name, "example")
  seal_metadata_service_name     = coalesce(var.seal_metadata_service_name, "rds")

  identifier = join("-", [local.seal_metadata_project_name, local.seal_metadata_environment_name, local.seal_metadata_service_name])
}

locals {
  engineInfo = lookup(local.engineInfos, var.engine)

  architecture = var.architecture

  namespace  = local.identifier
  name       = local.seal_metadata_service_name
  chart      = lookup(local.engineInfo, "chart")
  repository = lookup(local.engineInfo, "repository")
  tag        = lookup(local.engineInfo, "tag")
  driver     = lookup(local.engineInfo, "driver")
  port       = lookup(local.engineInfo, "port")
  database   = var.database
  username   = var.username
  password   = var.password

  init_sql_url       = var.init_sql_url
  emphemeral_storage = var.emphemeral_storage
}

#
# Install by Helm Chart.
#

resource "helm_release" "rds" {
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = local.chart
  wait             = false
  create_namespace = true
  max_history      = 3

  namespace = local.namespace
  name      = local.name

  values = [
    templatefile("${path.module}/templates/values.tftpl", {
      chart        = local.chart
      name         = local.name
      architecture = lower(local.architecture)
      image = {
        repository = local.repository
        tag        = local.tag
      }
      auth = {
        database = local.database
        username = local.username
      }
      persistence = {
        enabled = !local.emphemeral_storage
      }
      init_sql_url = local.init_sql_url
    })
  ]

  set_sensitive {
    name  = "auth.rootPassword"
    value = local.password
  }
  set_sensitive {
    name  = "auth.postgresPassword"
    value = local.password
  }
  set_sensitive {
    name  = "auth.replicationPassword"
    value = local.password
  }
  set_sensitive {
    name  = "auth.password"
    value = local.password
  }
}

#
# Get host/endpoint.
#

data "kubernetes_service_v1" "rds" {
  depends_on = [helm_release.rds]

  metadata {
    namespace = local.namespace
    name      = local.architecture == "Replication" ? format("%s-primary", local.name) : local.name
  }
}

data "kubernetes_service_v1" "rds_replica" {
  count = local.architecture == "Replication" ? 1 : 0

  depends_on = [helm_release.rds]

  metadata {
    namespace = local.namespace
    name      = format("%s-secondary", local.name)
  }
}

locals {
  host             = format("%s.%s.svc", data.kubernetes_service_v1.rds.metadata.0.name, local.namespace)
  host_replica     = local.architecture == "Replication" ? format("%s.%s.svc", data.kubernetes_service_v1.rds_replica.0.metadata.0.name, local.namespace) : null
  endpoint         = try(data.kubernetes_service_v1.rds.spec.0.cluster_ip, null)
  endpoint_replica = try(data.kubernetes_service_v1.rds_replica.0.spec.0.cluster_ip, null)
}
