# RDS Seeder

This module seeds any RDS for Development/Testing.

> Notes:
> - Lockable initializing SQL may cost more time.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_byteset"></a> [byteset](#requirement\_byteset) | >= 0.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_byteset"></a> [byteset](#provider\_byteset) | >= 0.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [byteset_pipeline.rds](https://registry.terraform.io/providers/seal-io/byteset/latest/docs/resources/pipeline) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_source_address"></a> [source\_address](#input\_source\_address) | Specify the seeding source address started with 'file://' or 'http(s)://' schema. | `string` | n/a | yes |
| <a name="input_destination_address"></a> [destination\_address](#input\_destination\_address) | Specify the seeding destiantion address. | `string` | n/a | yes |
| <a name="input_destination_conn_max"></a> [destination\_conn\_max](#input\_destination\_conn\_max) | Specify the connection maximum value of destination. | `number` | `5` | no |
| <a name="input_destination_batch_cap"></a> [destination\_batch\_cap](#input\_destination\_batch\_cap) | Specify the (insertion) batch capacity value of destination. | `number` | `500` | no |
| <a name="input_seal_metadata_project_name"></a> [seal\_metadata\_project\_name](#input\_seal\_metadata\_project\_name) | Seal metadata project name. | `string` | `""` | no |
| <a name="input_seal_metadata_environment_name"></a> [seal\_metadata\_environment\_name](#input\_seal\_metadata\_environment\_name) | Seal metadata environment name. | `string` | `""` | no |
| <a name="input_seal_metadata_service_name"></a> [seal\_metadata\_service\_name](#input\_seal\_metadata\_service\_name) | Seal metadata service name. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_cost"></a> [cost](#output\_cost) | n/a |
<!-- END_TF_DOCS -->
