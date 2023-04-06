# MySQL

This module provides a simplified way to deploy a MySQL database in a Kubernetes cluster using Helm. Helm is a package manager for Kubernetes that allows you to define, install, and manage complex applications on a Kubernetes cluster.

The module also generate the MySQL database access endpoint to output. 

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.mysql](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [random_string.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [kubernetes_service.mysql_service](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database"></a> [database](#input\_database) | Database name | `string` | `"mysql"` | no |
| <a name="input_init_db_script"></a> [init\_db\_script](#input\_init\_db\_script) | Init db scripts. | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to deploy. Auto-generated if empty. | `string` | `""` | no |
| <a name="input_password"></a> [password](#input\_password) | Password. Auto-generated if empty. | `string` | `""` | no |
| <a name="input_username"></a> [username](#input\_username) | Username | `string` | `"mysql"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_host"></a> [db\_host](#output\_db\_host) | n/a |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | n/a |
| <a name="output_db_password"></a> [db\_password](#output\_db\_password) | n/a |
| <a name="output_db_username"></a> [db\_username](#output\_db\_username) | n/a |
<!-- END_TF_DOCS -->
