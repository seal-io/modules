# Microservices Module

This module provides a demo to delpoy a microservices application that deploying in Kubernetes.

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.14.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.19.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.namespace](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/kubectl_manifest) | resource |
| [kubectl_path_documents_manifest](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/kubectl_path_documents) | data source |
| [kubectl_manifest.manifest](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/kubectl_manifest) | resource |
| [kubernetes_service.service](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|

## Outputs

| Name | Description |
|------|-------------|

<!-- END_TF_DOCS -->
