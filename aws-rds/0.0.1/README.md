# AWS RDS

This module provides the following RDS engines of AWS.

- MySQL
- MariaDB
- PostgreSQL

> Notes:
> - Provisioning takes almost 5-10 mins without any SQL initialization.
> - Lockable initializing SQL may cost more time.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_byteset"></a> [byteset](#provider\_byteset) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance.rds_replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_internet_gateway.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route.rds_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_security_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_all_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [byteset_pipeline.init_sql](https://registry.terraform.io/providers/seal-io/byteset/latest/docs/resources/pipeline) | resource |
| [aws_availability_zones.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_subnets.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_engine"></a> [engine](#input\_engine) | Select the RDS engine, support serval kinds of 'MySQL', 'MariaDB' and 'PostgreSQL'. | `string` | n/a | yes |
| <a name="input_architecture"></a> [architecture](#input\_architecture) | Select the RDS architecture, support from 'Standalone' and 'Replication'. | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | Specify the root password to initialize after launching. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Specify the root username to initialize after launching. | `string` | `"rdsusr"` | no |
| <a name="input_database"></a> [database](#input\_database) | Specify the database name to initialize after launching. | `string` | `"rdsdb"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Specify the instance type to deploy the RDS engine, pick burstable 2C4G type automatically if empty. | `string` | `""` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | Specify the storage type to deploy the RDS engine, pick GP2 if empty. | `string` | `""` | no |
| <a name="input_init_sql_url"></a> [init\_sql\_url](#input\_init\_sql\_url) | Specify the init SQL download URL to initialize after launching. | `string` | `""` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Specify to allow publicly accessing. | `bool`   | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Specify the existing VPC ID to deploy, create a new one if empty. | `string` | `""` | no |
| <a name="input_seal_metadata_project_name"></a> [seal\_metadata\_project\_name](#input\_seal\_metadata\_project\_name) | Seal metadata project name. | `string` | `""` | no |
| <a name="input_seal_metadata_environment_name"></a> [seal\_metadata\_environment\_name](#input\_seal\_metadata\_environment\_name) | Seal metadata environment name. | `string` | `""` | no |
| <a name="input_seal_metadata_service_name"></a> [seal\_metadata\_service\_name](#input\_seal\_metadata\_service\_name) | Seal metadata service name. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_endpoint"></a> [db\_endpoint](#output\_db\_endpoint) | n/a |
| <a name="output_db_host"></a> [db\_host](#output\_db\_host) | n/a |
| <a name="output_db_endpoint_replica"></a> [db\_endpoint\_replica](#output\_db\_endpoint\_replica) | n/a |
| <a name="output_db_host_replica"></a> [db\_host\_replica](#output\_db\_host\_replica) | n/a |
| <a name="output_db_driver"></a> [db\_driver](#output\_db\_driver) | n/a |
| <a name="output_db_port"></a> [db\_port](#output\_db\_port) | n/a |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | n/a |
| <a name="output_db_username"></a> [db\_username](#output\_db\_username) | n/a |
| <a name="output_db_password"></a> [db\_password](#output\_db\_password) | n/a |
<!-- END_TF_DOCS -->
