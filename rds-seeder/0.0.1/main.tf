#
# Prepare locals.
#

locals {
  seal_metadata_project_name     = coalesce(var.seal_metadata_project_name, "example")
  seal_metadata_environment_name = coalesce(var.seal_metadata_environment_name, "example")
  seal_metadata_service_name     = coalesce(var.seal_metadata_service_name, "rdsseeder")

  identifier = join("-", [local.seal_metadata_project_name, local.seal_metadata_environment_name, local.seal_metadata_service_name])
}

locals {
  source_address       = var.source_address
  destination_address  = var.destination_address
  destination_conn_max = var.destination_conn_max
}

#
# Create Pipeline.
#

resource "byteset_pipeline" "rds" {
  source = {
    address = local.source_address
  }

  destination = {
    address  = local.destination_address
    conn_max = local.destination_conn_max
    salt     = local.identifier
  }
}

#
# Get id.
#
locals {
  id = byteset_pipeline.rds.id
}
