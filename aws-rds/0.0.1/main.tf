#
# Constants.
#
locals {
  engineInfos = tomap({
    # Ref to https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html.

    # 
    #
    # MySQL.
    #

    "MySQL-5.7" : {
      "driver" : "mysql",
      "port" : 3306,
      "engine" : "mysql",
      "engineVersion" : "5.7",
      "instanceType" : "db.t3.medium",
      "parameterFamily" : "mysql5.7",
      "parameters" : [
        {
          "name" : "innodb_log_buffer_size",
          "value" : "268435456",
        },
        {
          "name" : "innodb_log_file_size",
          "value" : "1073741824",
        },
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
      "engine" : "mysql",
      "engineVersion" : "8.0",
      "instanceType" : "db.t3.medium",
      "parameterFamily" : "mysql8.0",
      "parameters" : [
        {
          "name" : "innodb_log_buffer_size",
          "value" : "268435456",
        },
        {
          "name" : "innodb_log_file_size",
          "value" : "1073741824",
        },
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
      "engine" : "mariadb",
      "engineVersion" : "10.3.39",
      "instanceType" : "db.t3.medium",
      "parameterFamily" : "mariadb10.3",
      "parameters" : [
        {
          "name" : "innodb_log_buffer_size",
          "value" : "268435456",
        },
        {
          "name" : "innodb_log_file_size",
          "value" : "1073741824",
        },
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

    "MariaDB-10.4" : {
      "driver" : "mariadb",
      "port" : 3306,
      "engine" : "mariadb",
      "engineVersion" : "10.4.29",
      "instanceType" : "db.t3.medium",
      "parameterFamily" : "mariadb10.4",
      "parameters" : [
        {
          "name" : "innodb_log_buffer_size",
          "value" : "268435456",
        },
        {
          "name" : "innodb_log_file_size",
          "value" : "1073741824",
        },
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

    "MariaDB-10.5" : {
      "driver" : "mariadb",
      "port" : 3306,
      "engine" : "mariadb",
      "engineVersion" : "10.5.20",
      "instanceType" : "db.t3.medium",
      "parameterFamily" : "mariadb10.5",
      "parameters" : [
        {
          "name" : "innodb_log_buffer_size",
          "value" : "268435456",
        },
        {
          "name" : "innodb_log_file_size",
          "value" : "1073741824",
        },
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

    "MariaDB-10.6" : {
      "driver" : "mariadb",
      "port" : 3306,
      "engine" : "mariadb",
      "engineVersion" : "10.6.13",
      "instanceType" : "db.t3.medium",
      "parameterFamily" : "mariadb10.6",
      "parameters" : [
        {
          "name" : "innodb_log_buffer_size",
          "value" : "268435456",
        },
        {
          "name" : "innodb_log_file_size",
          "value" : "1073741824",
        },
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
      "engine" : "postgres",
      "engineVersion" : "13.11",
      "instanceType" : "db.t3.medium",
      "parameterFamily" : "postgres13",
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
      "engine" : "postgres",
      "engineVersion" : "14.8",
      "instanceType" : "db.t3.medium",
      "parameterFamily" : "postgres14",
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
      "engine" : "postgres",
      "engineVersion" : "15.3",
      "instanceType" : "db.t3.medium",
      "parameterFamily" : "postgres15",
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
  seal_metadata_service_name     = coalesce(var.seal_metadata_service_name, "awsrds")

  identifier = join("-", [local.seal_metadata_project_name, local.seal_metadata_environment_name, local.seal_metadata_service_name])
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
  instance_type   = coalesce(var.instance_type, lookup(local.engineInfo, "instanceType"))
  storage_type    = coalesce(var.storage_type, "gp2")
  vpc_create      = var.vpc_id == ""
  vpc_create_cidr = "10.0.0.0/16"
}

#
# Ensure VPC.
#

data "aws_availability_zones" "rds" {
  count = local.vpc_create ? 1 : 0

  state = "available"

  lifecycle {
    postcondition {
      condition     = local.architecture == "Replication" ? length(self.names) > 1 : length(self.names) > 0
      error_message = "Failed to get Avaialbe Zones"
    }
  }
}

resource "aws_vpc" "rds" {
  count = local.vpc_create ? 1 : 0

  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  cidr_block           = local.vpc_create_cidr

  tags = local.tags
}

locals {
  vpc_create_zones   = try(data.aws_availability_zones.rds.0.names, [])
  vpc_create_subnets = [for k, v in local.vpc_create_zones : cidrsubnet(local.vpc_create_cidr, 8, k)]
}

resource "aws_subnet" "rds" {
  count = local.vpc_create ? length(local.vpc_create_subnets) : 0

  vpc_id            = aws_vpc.rds.0.id
  availability_zone = element(local.vpc_create_zones, count.index)
  cidr_block        = element(local.vpc_create_subnets, count.index)

  tags = local.tags
}

resource "aws_internet_gateway" "rds" {
  count = local.vpc_create ? 1 : 0

  vpc_id = aws_vpc.rds.0.id

  tags = local.tags
}

resource "aws_route" "rds_internet_gateway" {
  count = local.vpc_create ? 1 : 0

  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_vpc.rds.0.default_route_table_id
  gateway_id             = aws_internet_gateway.rds.0.id
}

data "aws_vpc" "rds" {
  count = !local.vpc_create ? 1 : 0

  id = var.vpc_id
}

data "aws_subnets" "rds" {
  count = !local.vpc_create ? 1 : 0

  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  lifecycle {
    postcondition {
      condition     = local.architecture == "Replication" ? length(self.ids) > 1 : length(self.ids) > 0
      error_message = "Failed to get available Subnet."
    }
  }
}

locals {
  vpc_id      = local.vpc_create ? aws_vpc.rds.0.id : data.aws_vpc.rds.0.id
  vpc_cidr    = local.vpc_create ? aws_vpc.rds.0.cidr_block : data.aws_vpc.rds.0.cidr_block
  vpc_subnets = local.vpc_create ? aws_subnet.rds.*.id : data.aws_subnets.rds.0.ids
}

#
# Ensure Security Group.
#

resource "aws_security_group" "rds" {
  name   = local.identifier
  vpc_id = local.vpc_id

  tags = local.tags
}

resource "aws_security_group_rule" "allow_all_tcp" {
  cidr_blocks = [local.publicly_accessible ? "0.0.0.0/0" : local.vpc_cidr]

  type              = "ingress"
  from_port         = local.port
  to_port           = local.port
  protocol          = "tcp"
  security_group_id = aws_security_group.rds.id
}

#
# Create Database.
#

resource "aws_db_subnet_group" "rds" {
  name       = local.identifier
  subnet_ids = local.vpc_subnets

  tags = local.tags
}

resource "aws_db_parameter_group" "rds" {
  name   = local.identifier
  family = lookup(local.engineInfo, "parameterFamily")

  dynamic "parameter" {
    for_each = lookup(local.engineInfo, "parameters")
    content {
      name         = parameter.value["name"]
      value        = parameter.value["value"]
      apply_method = "pending-reboot"
    }
  }
}

resource "aws_db_instance" "rds" {
  publicly_accessible = local.publicly_accessible

  identifier     = local.identifier
  engine         = local.engine
  engine_version = local.engine_version
  instance_class = local.instance_type

  db_name  = local.database
  port     = local.port
  username = local.username
  password = local.password

  storage_type          = local.storage_type
  max_allocated_storage = 100
  allocated_storage     = 20

  multi_az               = local.architecture == "Replication"
  db_subnet_group_name   = aws_db_subnet_group.rds.id
  vpc_security_group_ids = [aws_security_group.rds.id]

  apply_immediately       = true
  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false

  parameter_group_name = aws_db_parameter_group.rds.name

  tags = local.tags
}

resource "aws_db_instance" "rds_replica" {
  count = local.architecture == "Replication" ? 1 : 0

  publicly_accessible = aws_db_instance.rds.publicly_accessible

  identifier     = join("-", [aws_db_instance.rds.identifier, "replica"])
  engine         = aws_db_instance.rds.engine
  engine_version = aws_db_instance.rds.engine_version
  instance_class = aws_db_instance.rds.instance_class

  replicate_source_db = aws_db_instance.rds.arn
  port                = aws_db_instance.rds.port

  storage_type = aws_db_instance.rds.storage_type

  multi_az               = false
  db_subnet_group_name   = aws_db_instance.rds.db_subnet_group_name
  vpc_security_group_ids = aws_db_instance.rds.vpc_security_group_ids

  apply_immediately       = true
  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  parameter_group_name = aws_db_instance.rds.parameter_group_name

  tags = local.tags
}

#
# Get host/endpoint.
#

locals {
  host             = aws_db_instance.rds.address
  host_replica     = try(aws_db_instance.rds_replica.0.address, null)
  endpoint         = local.host
  endpoint_replica = local.host_replica
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
      ((contains(["mysql", "mariadb"], local.driver)) ? format("tcp(%s:%d)", local.host, local.port) : format("%s:%d", local.host, local.port)),
      local.database,
      (contains(["postgres"], local.driver) ? "?sslmode=disable" : "")
    )

    salt = aws_db_instance.rds.id
  }
}
