
# Module `aws-rds-test`

Provider Requirements:
* **aws:** (any version)

## Input Variables
* `db_allocated_storage` (required): Amount of storage to allocate for the database, in GB
* `db_backup_retention_period` (required): Number of days to retain backups for the database
* `db_engine` (required): Database engine type
* `db_engine_version` (required): Database engine version
* `db_instance_class` (default `"default"`): Instance class of the database
* `db_multi_az` (required): Whether to enable multi-AZ deployment for the database
* `db_name` (required): Name of the database
* `db_parameter_group_name` (required): Name of the parameter group for the database
* `db_password` (required): Password for the database
* `db_security_groups` (required): List of security groups to associate with the database
* `db_subnet_group_name` (required): Name of the subnet group for the database
* `db_tags` (required): Map of tags to apply to the database
* `db_username` (required): Username for the database

## Output Values
* `db_endpoint`: Endpoint for the database
* `db_password`: Password for the database
* `db_username`: Username for the database

## Managed Resources
* `aws_db_instance.example` from `aws`
* `aws_db_subnet_group.example` from `aws`

