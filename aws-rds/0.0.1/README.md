# AWS RDS

This module provides a streamlined way to provision and manage Amazon RDS instances, which are fully managed relational databases in the cloud. With this module, you can easily define and configure your RDS instances and related resources, such as security groups and parameter groups, using a simple and intuitive syntax.

In addition to provisioning RDS instances, this module also generates an RDS access endpoint as output. This endpoint provides a direct connection to your RDS instance, allowing you to easily access and manage your database. The endpoint can be used in your application code or scripts.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 2.77.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.education](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.education](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.education](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | RDS root user password | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"ap-northeast-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rds_hostname"></a> [rds\_hostname](#output\_rds\_hostname) | RDS instance hostname |
| <a name="output_rds_port"></a> [rds\_port](#output\_rds\_port) | RDS instance port |
| <a name="output_rds_username"></a> [rds\_username](#output\_rds\_username) | RDS instance root username |
