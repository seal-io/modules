
# Module `awsrdsbeta`

Provider Requirements:
* **aws:** (any version)

## Input Variables
* `db_allocated_storage` (default `10`): Allocated storage for the RDS instance
* `db_backup_retention_period` (default `7`): Number of days to retain backups for
* `db_engine` (default `"mysql"`): Database engine to be used
* `db_engine_version` (default `"5.7"`): Version of the database engine to be used
* `db_instance_class` (default `"db.t2.micro"`): Instance class for the RDS instance
* `db_multi_az` (default `false`): Enable multi-AZ deployment
* `db_name` (required): Name of the database to be created
* `db_parameter_group_name` (required): Name of the DB parameter group
* `db_password` (required): Password for the database
* `db_security_group_ids` (required): List of security group IDs to be associated with the RDS instance
* `db_subnet_group_name` (required): Name of the DB subnet group
* `db_tags` (default `{}`): Map of tags to be applied to the RDS instance
* `db_username` (required): Username for the database

## Output Values
* `db_instance_endpoint`
* `db_instance_password`
* `db_instance_username`

## Managed Resources
* `aws_db_instance.rds_instance` from `aws`

