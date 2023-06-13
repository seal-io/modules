#
# Constants.
#
locals {
  engineInfos = tomap({
    # Ref to https://www.alibabacloud.com/help/zh/apsaradb-for-rds/latest/primary-apsaradb-rds-instance-types.

    # 
    #
    # MySQL.
    #

    "MySQL-5.7" : {
      "driver" : "mysql",
      "port" : 3306,
      "engine" : "MySQL",
      "engineVersion" : "5.7",
      "instanceTypeStandalone" : "mysql.n2.medium.1",
      "instanceTypeReplication" : "mysql.n2.medium.2c",
      "parameters" : [
        {
          "name" : "innodb_flush_log_at_trx_commit",
          "value" : "2",
        },
        {
          "name" : "sync_binlog",
          "value" : "1000",
        }
      ],
    },
    "MySQL-8.0" : {
      "driver" : "mysql",
      "port" : 3306,
      "engine" : "MySQL",
      "engineVersion" : "8.0",
      "instanceTypeStandalone" : "mysql.n2.medium.1",
      "instanceTypeReplication" : "mysql.n2.medium.2c",
      "parameters" : [
        {
          "name" : "innodb_flush_log_at_trx_commit",
          "value" : "2",
        },
        {
          "name" : "sync_binlog",
          "value" : "1000",
        }
      ],
    },

    #
    # MariaDB.
    #

    "MariaDB-10.3" : {
      "driver" : "mariadb",
      "port" : 3306,
      "engine" : "MariaDB",
      "engineVersion" : "10.3",
      "instanceTypeStandalone" : null,
      "instanceTypeReplication" : "mariadb.n2.medium.2c",
      "parameters" : [
        {
          "name" : "innodb_flush_log_at_trx_commit",
          "value" : "2",
        },
        {
          "name" : "sync_binlog",
          "value" : "1000",
        }
      ],
    },

    #
    # PostgreSQL.
    #

    "PostgreSQL-13" : {
      "driver" : "postgres",
      "port" : 5432,
      "engine" : "PostgreSQL",
      "engineVersion" : "13.0",
      "instanceTypeStandalone" : "pg.n2.2c.1m",
      "instanceTypeReplication" : "pg.n2.2c.2m",
      "parameters" : [
        {
          "name" : "synchronous_commit",
          "value" : "off",
        }
      ],
    },
    "PostgreSQL-14" : {
      "driver" : "postgres",
      "port" : 5432,
      "engine" : "PostgreSQL",
      "engineVersion" : "14.0",
      "instanceTypeStandalone" : "pg.n2.2c.1m",
      "instanceTypeReplication" : "pg.n2.2c.2m",
      "parameters" : [
        {
          "name" : "synchronous_commit",
          "value" : "off",
        }
      ],
    },
    "PostgreSQL-15" : {
      "driver" : "postgres",
      "port" : 5432,
      "engine" : "PostgreSQL",
      "engineVersion" : "15.0",
      "instanceTypeStandalone" : "pg.n2.2c.1m",
      "instanceTypeReplication" : "pg.n2.2c.2m",
      "parameters" : [
        {
          "name" : "synchronous_commit",
          "value" : "off",
        }
      ],
    },

  })
}

#
# Prepare locals.
#

locals {
  seal_metadata_project_name     = coalesce(var.seal_metadata_project_name, "example")
  seal_metadata_environment_name = coalesce(var.seal_metadata_environment_name, "example")
  seal_metadata_service_name     = coalesce(var.seal_metadata_service_name, "alicloudrds")

  identifier = join("-", [local.seal_metadata_project_name, local.seal_metadata_environment_name, local.var.seal_metadata_service_name])
}

locals {
  engineInfo = lookup(local.engineInfos, var.engine)

  architecture = var.architecture

  engine         = lookup(local.engineInfo, "engine")
  engine_version = lookup(local.engineInfo, "engineVersion")
  driver         = lookup(local.engineInfo, "driver")
  port           = lookup(local.engineInfo, "port")
  database       = var.database
  username       = var.username
  password       = var.password

  sql_init            = var.init_sql_url != ""
  publicly_accessible = var.publicly_accessible || local.sql_init
  tags = {
    "seal_project"     = local.seal_metadata_project_name
    "seal_environment" = local.seal_metadata_environment_name
    "seal_service"     = local.seal_metadata_service_name
  }
  instance_type   = coalesce(var.instance_type, lookup(local.engineInfo, format("instanceType%s", local.architecture)))
  storage_type    = coalesce(var.storage_type, "cloud_essd")
  vpc_create      = var.vpc_id == ""
  vpc_create_cidr = "10.0.0.0/16"
}

#
# Ensure VPC.
#

data "alicloud_db_zones" "rds" {
  count = local.vpc_create ? 1 : 0

  engine                   = local.engine
  engine_version           = local.engine_version
  category                 = local.architecture == "Replication" ? "HighAvailability" : "Basic"
  db_instance_storage_type = local.storage_type

  lifecycle {
    postcondition {
      condition     = local.architecture == "Replication" ? length(self.ids) > 1 : length(self.ids) > 0
      error_message = "Failed to get Avaialbe Zones"
    }
  }
}

resource "alicloud_vpc" "rds" {
  count = local.vpc_create ? 1 : 0

  vpc_name   = local.identifier
  cidr_block = local.vpc_create_cidr

  tags = local.tags
}

locals {
  vpc_create_zones   = try(data.alicloud_db_zones.rds.0.ids, [])
  vpc_create_subnets = [for k, v in local.vpc_create_zones : cidrsubnet(local.vpc_create_cidr, 8, k)]
}

resource "alicloud_vswitch" "rds" {
  count = local.vpc_create ? length(local.vpc_create_subnets) : 0

  vpc_id     = alicloud_vpc.rds.0.id
  zone_id    = element(local.vpc_create_zones, count.index)
  cidr_block = element(local.vpc_create_subnets, count.index)

  tags = local.tags
}

data "alicloud_vpcs" "rds" {
  count = !local.vpc_create ? 1 : 0

  ids = [var.vpc_id]

  lifecycle {
    postcondition {
      condition     = length(self.ids) == 1
      error_message = "Failed to get available VPC"
    }
  }
}

data "alicloud_vswitches" "rds" {
  count = !local.vpc_create ? 1 : 0

  vpc_id = var.vpc_id

  lifecycle {
    postcondition {
      condition     = local.architecture == "Replication" ? length(self.ids) > 1 : length(self.ids) > 0
      error_message = "Failed to get available VSwitch"
    }
  }
}

locals {
  vpc_id      = local.vpc_create ? alicloud_vpc.rds.0.id : data.alicloud_vpcs.rds.0.vpcs.0.id
  vpc_cidr    = local.vpc_create ? alicloud_vpc.rds.0.cidr_block : data.alicloud_vpcs.rds.0.vpcs.0.cidr_block
  vpc_subnets = local.vpc_create ? alicloud_vswitch.rds.*.id : data.alicloud_vswitches.rds.0.vswitches.*.id
  vpc_zones   = local.vpc_create ? alicloud_vswitch.rds.*.zone_id : data.alicloud_vswitches.rds.0.vswitches.*.zone_id
}

#
# Ensure Security Group.
#

resource "alicloud_security_group" "rds" {
  name   = local.identifier
  vpc_id = local.vpc_id

  tags = local.tags
}

resource "alicloud_security_group_rule" "allow_all_tcp" {
  cidr_ip = local.publicly_accessible ? "0.0.0.0/0" : local.vpc_cidr

  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = format("%d/%d", local.port, local.port)
  priority          = 1
  security_group_id = alicloud_security_group.rds.id
}

#
# Create Database.
#

resource "alicloud_db_instance" "rds" {
  security_ips = [local.publicly_accessible ? "0.0.0.0/0" : local.vpc_cidr]

  instance_name  = local.identifier
  engine         = local.engine
  engine_version = local.engine_version
  instance_type  = local.instance_type

  db_instance_storage_type = local.storage_type
  storage_auto_scale       = contains(["MySQL", "PostgreSQL"], local.engine) ? "Enable" : "Disable"
  storage_threshold        = contains(["MySQL", "PostgreSQL"], local.engine) ? "20" : null
  storage_upper_bound      = contains(["MySQL", "PostgreSQL"], local.engine) ? "100" : null
  instance_storage         = contains(["MySQL", "PostgreSQL"], local.engine) ? "20" : "100"


  category           = local.architecture == "Replication" ? "HighAvailability" : "Basic"
  vpc_id             = local.vpc_id
  vswitch_id         = local.architecture == "Replication" ? join(",", [local.vpc_subnets.0, local.vpc_subnets.1]) : local.vpc_subnets.0
  security_group_ids = [alicloud_security_group.rds.id]
  zone_id            = local.vpc_zones.0
  zone_id_slave_a    = local.architecture == "Replication" ? local.vpc_zones.1 : null

  deletion_protection = contains(["MySQL", "PostgreSQL", "MariaDB"], local.engine) ? false : null

  dynamic "parameters" {
    for_each = lookup(local.engineInfo, "parameters")
    content {
      name  = parameters.value["name"]
      value = parameters.value["value"]
    }
  }

  tags = local.tags
}

resource "alicloud_db_database" "default" {
  instance_id = alicloud_db_instance.rds.id
  name        = local.database
}

resource "alicloud_rds_account" "rds" {
  db_instance_id   = alicloud_db_instance.rds.id
  account_type     = "Super"
  account_name     = local.username
  account_password = local.password
}

resource "alicloud_db_connection" "rds" {
  instance_id = alicloud_db_instance.rds.id
  port        = local.port
}

#
# Get host/endpoint.
#

locals {
  host             = alicloud_db_connection.rds.connection_string
  host_replica     = local.architecture == "Replication" ? local.host : null
  endpoint         = alicloud_db_connection.rds.ip_address
  endpoint_replica = local.architecture == "Replication" ? local.endpoint : null
}

#
# Seed Database.
#

resource "byteset_pipeline" "init_sql" {
  count = local.sql_init ? 1 : 0

  source = {
    address = var.init_sql_url
  }

  destination = {
    address = format("%s://%s:%s@%s/%s%s",
      local.driver,
      local.username,
      local.password,
      (contains(["mysql", "mariadb"], local.driver) ? format("tcp(%s:%d)", local.host, local.port) : format("%s:%d", local.host, local.port)),
      local.database,
      (contains(["postgres"], local.driver) ? "?sslmode=disable" : "")
    )

    salt = alicloud_db_instance.rds.id
  }
}

