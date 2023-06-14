terraform {
  required_version = ">= 1.0"

  required_providers {
    byteset = {
      source = "seal-io/byteset"
    }
  }
}

provider "aws" {
}

provider "byteset" {
}

resource "random_string" "password" {
  length  = 16
  special = false
}

locals {
  password = random_string.password.result
}

module "aws" {
  source = "../../../aws-rds/0.0.1"

  engine              = "MySQL-8.0"
  architecture        = "Standalone"
  password            = local.password
  publicly_accessible = true
}

module "seed" {
  source = "../../0.0.1"

  depends_on = [module.aws]

  source_address = "https://raw.githubusercontent.com/seal-io/terraform-provider-byteset/main/byteset/testdata/mysql.sql"
  destination_address = format("%s://%s:%s@%s/%s%s",
    module.aws.db_driver,
    module.aws.db_username,
    module.aws.db_password,
    (contains(["mysql", "mariadb"], module.aws.db_driver) ? format("tcp(%s:%d)", module.aws.db_host, module.aws.db_port) : format("%s:%d", module.aws.db_host, module.aws.db_port)),
    module.aws.db_name,
    (contains(["postgres"], module.aws.db_driver) ? "?sslmode=disable" : "")
  )
}
