# RDS

This module provides the following RDS engines of Kubernetes via [Bitnami Charts](https://github.com/bitnami/charts).

- MySQL
- MariaDB
- PostgreSQL

> Notes:
> - Lockable initializing SQL may cost more time.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.rds](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_service_v1.rds](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service_v1) | data source |
| [kubernetes_service_v1.rds_replica](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service_v1) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_engine"></a> [engine](#input\_engine) | Select the RDS engine, support serval kinds of 'MySQL', 'MariaDB' and 'PostgreSQL'. | `string` | n/a | yes |
| <a name="input_architecture"></a> [architecture](#input\_architecture) | Select the RDS architecture, support from 'Standalone' and 'Replication'. | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | Specify the root password to initialize after launching. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Specify the root username to initialize after launching, 'MySQL' and 'MariaDB' engines don't allow 'root'. | `string` | `"rdsusr"` | no |
| <a name="input_database"></a> [database](#input\_database) | Specify the database name to initialize after launching. | `string` | `"rdsdb"` | no |
| <a name="input_emphemeral_storage"></a> [emphemeral\_storage](#input\_emphemeral\_storage) | Specify to use emphemeral storage, which is nice for testing. | `bool` | `false` | no |
| <a name="input_init_sql_url"></a> [init\_sql\_url](#input\_init\_sql\_url) | Specify the init SQL download URL to initialize after launching. | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Specify the Kubernetes namespace to deploy, generate automatically if empty. | `string` | `""` | no |
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
