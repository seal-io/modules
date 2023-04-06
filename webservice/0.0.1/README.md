# Web Service Module

This module provides an efficient way to create a Kubernetes deployment and service for a web service.

It will generate an access endpoint as output for your web service, allowing it to be accessed from other services or applications.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.14.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_deployment"></a> [deployment](#module\_deployment) | terraform-iaac/deployment/kubernetes | 1.4.2 |
| <a name="module_service"></a> [service](#module\_service) | terraform-iaac/service/kubernetes | 1.0.4 |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.ns](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubernetes_service.service](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Name and value pairs to set as the environment variables | `map(string)` | `{}` | no |
| <a name="input_image"></a> [image](#input\_image) | Docker image name | `string` | n/a | yes |
| <a name="input_limit_cpu"></a> [limit\_cpu](#input\_limit\_cpu) | CPU limit. e.g. 0.5, 1, 2 | `string` | `""` | no |
| <a name="input_limit_memory"></a> [limit\_memory](#input\_limit\_memory) | Memory limit. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the deployment resource. Auto-generated if empty. | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to deploy. Auto-generated if empty. | `string` | `""` | no |
| <a name="input_ports"></a> [ports](#input\_ports) | Service ports to expose | `list(number)` | <pre>[<br>  80<br>]</pre> | no |
| <a name="input_request_cpu"></a> [request\_cpu](#input\_request\_cpu) | CPU request. e.g. 0.5, 1, 2 | `string` | `"0.1"` | no |
| <a name="input_request_memory"></a> [request\_memory](#input\_request\_memory) | Memory request. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi | `string` | `"128Mi"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ports"></a> [ports](#output\_ports) | Service Ports |
| <a name="output_service_ip"></a> [service\_ip](#output\_service\_ip) | Service IP |
<!-- END_TF_DOCS -->
