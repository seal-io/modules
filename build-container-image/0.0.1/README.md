# Build Container Image

Kaniko is an open-source tool that provides a secure way to build container image without requiring a Docker daemon. This module utilizes the power of Kaniko to build container image using a Dockerfile fetched from GitHub.

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
