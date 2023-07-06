# Deploy Source Code

Kaniko is an open-source tool that provides a secure way to build container image without requiring a Docker daemon. This module utilizes the power of Kaniko to build container image using a Dockerfile fetched from GitHub, as well as the deployment of it to a Kubernetes cluster.

This module will also generate to image name to output.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kaniko"></a> [kaniko](#requirement\_kaniko) | 0.0.1-dev1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kaniko"></a> [kaniko](#provider\_kaniko) | 0.0.1-dev1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kaniko_image.image](https://registry.terraform.io/providers/gitlawr/kaniko/0.0.1-dev1/docs/resources/image) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dockerfile"></a> [dockerfile](#input\_dockerfile) | Path to the Dockerfile. | `string` | `"Dockerfile"` | no |
| <a name="input_git_auth"></a> [git\_auth](#input\_git\_auth) | @label "Authentication" @group "Source" | `bool` | `false` | no |
| <a name="input_git_branch"></a> [git\_branch](#input\_git\_branch) | Branch of the repository to clone. | `string` | `"main"` | no |
| <a name="input_git_password"></a> [git\_password](#input\_git\_password) | Password for cloning the git repository. | `string` | `null` | no |
| <a name="input_git_path"></a> [git\_path](#input\_git\_path) | Path to the source code. | `string` | `null` | no |
| <a name="input_git_url"></a> [git\_url](#input\_git\_url) | URL to the source code repository. | `string` | n/a | yes |
| <a name="input_git_username"></a> [git\_username](#input\_git\_username) | Username for cloning the git repository. | `string` | `null` | no |
| <a name="input_image"></a> [image](#input\_image) | Name of the image to be built and deployed. | `string` | n/a | yes |
| <a name="input_registry_auth"></a> [registry\_auth](#input\_registry\_auth) | @label "Registry Authentication" @group "Build" | `bool` | `false` | no |
| <a name="input_registry_password"></a> [registry\_password](#input\_registry\_password) | Password for the image registry. | `string` | `null` | no |
| <a name="input_registry_username"></a> [registry\_username](#input\_registry\_username) | Username for the image registry. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_image"></a> [image](#output\_image) | Built docker image name |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kaniko"></a> [kaniko](#requirement\_kaniko) | 0.0.1-dev1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kaniko"></a> [kaniko](#provider\_kaniko) | 0.0.1-dev1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_deployment"></a> [deployment](#module\_deployment) | terraform-iaac/deployment/kubernetes | 1.4.2 |
| <a name="module_service"></a> [service](#module\_service) | terraform-iaac/service/kubernetes | 1.0.4 |

## Resources

| Name | Type |
|------|------|
| [kaniko_image.image](https://registry.terraform.io/providers/gitlawr/kaniko/0.0.1-dev1/docs/resources/image) | resource |
| [kubernetes_service.service](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dockerfile"></a> [dockerfile](#input\_dockerfile) | Path to the Dockerfile. | `string` | `"Dockerfile"` | no |
| <a name="input_env"></a> [env](#input\_env) | Name and value pairs to set as the environment variables | `map(string)` | `{}` | no |
| <a name="input_git_auth"></a> [git\_auth](#input\_git\_auth) | @label "Git Authentication" @group "Build" | `bool` | `false` | no |
| <a name="input_git_branch"></a> [git\_branch](#input\_git\_branch) | Branch of the repository to clone. | `string` | `"main"` | no |
| <a name="input_git_password"></a> [git\_password](#input\_git\_password) | Password for cloning the git repository. | `string` | `null` | no |
| <a name="input_git_path"></a> [git\_path](#input\_git\_path) | Path to the source code. | `string` | `null` | no |
| <a name="input_git_url"></a> [git\_url](#input\_git\_url) | URL to the source code repository. | `string` | n/a | yes |
| <a name="input_git_username"></a> [git\_username](#input\_git\_username) | Username for cloning the git repository. | `string` | `null` | no |
| <a name="input_image"></a> [image](#input\_image) | Name of the image to be built and deployed. | `string` | n/a | yes |
| <a name="input_limit_cpu"></a> [limit\_cpu](#input\_limit\_cpu) | CPU limit. e.g. 0.5, 1, 2 | `string` | `""` | no |
| <a name="input_limit_memory"></a> [limit\_memory](#input\_limit\_memory) | Memory limit. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the deployment resource. Auto-generated if empty. | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to deploy. Auto-generated if empty. | `string` | `""` | no |
| <a name="input_ports"></a> [ports](#input\_ports) | Service ports to expose | `list(number)` | <pre>[<br>  80<br>]</pre> | no |
| <a name="input_registry_auth"></a> [registry\_auth](#input\_registry\_auth) | @label "Registry Authentication" @group "Build" | `bool` | `false` | no |
| <a name="input_registry_password"></a> [registry\_password](#input\_registry\_password) | Password for the image registry. | `string` | `null` | no |
| <a name="input_registry_username"></a> [registry\_username](#input\_registry\_username) | Username for the image registry. | `string` | `null` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | Count of pods | `number` | `1` | no |
| <a name="input_request_cpu"></a> [request\_cpu](#input\_request\_cpu) | CPU request. e.g. 0.5, 1, 2 | `string` | `"0.1"` | no |
| <a name="input_request_memory"></a> [request\_memory](#input\_request\_memory) | Memory request. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi | `string` | `"128Mi"` | no |
| <a name="input_seal_metadata_namespace_name"></a> [seal\_metadata\_namespace\_name](#input\_seal\_metadata\_namespace\_name) | Seal metadata namespace name. | `string` | `""` | no |
| <a name="input_seal_metadata_service_name"></a> [seal\_metadata\_service\_name](#input\_seal\_metadata\_service\_name) | Seal metadata service name. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_image"></a> [image](#output\_image) | Build and deploy docker image name |
| <a name="output_ports"></a> [ports](#output\_ports) | Service Ports |
| <a name="output_service_ip"></a> [service\_ip](#output\_service\_ip) | Service IP |
<!-- END_TF_DOCS -->