
# Module `alicloud-rds`

Provider Requirements:
* **alicloud:** (any version)

## Input Variables
* `db_name` (default `"mydb"`): The name of the database
* `db_password` (default `"password123"`): The password for the database
* `db_username` (default `"admin"`): The username for the database

## Output Values
* `db_endpoint`
* `db_password`
* `db_username`

## Managed Resources
* `alicloud_db_instance.rds` from `alicloud`

