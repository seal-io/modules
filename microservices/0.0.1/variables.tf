# @group "Kubernetes Configuration"
# @label "命名空间"
variable "namespace" {
  description = "Namespace to deploy"
  type        = string 
}

# @group "Image Configuration"
# @label "镜像仓库地址"
variable "image_registry" {
  description = "Image registry"
  type        = string
  default     = "docker.io"
}


# @group "Image Configuration"
# @label "镜像仓库项目"
variable "image_repository" {
  description = "Image repository"
  type        = string
  default     = "liyinlin"
}


# @group "Image Configuration"
# @label "镜像版本"
variable "image_version" {
  description = "Image tag"
  type        = string
  default     = "v0.6.0"
}

# @hidden
variable "frontend_service_name" {
  type        = string
  description = "Online Boutique frontend service name"
  default     = "frontend-external"
}

# @hidden
variable "seal_metadata_application_name" {
  type        = string
  description = "Seal metadata application name."
  default     = ""
}
# @hidden
variable "seal_metadata_application_instance_name" {
  type        = string
  description = "Seal metadata application instance name."
  default     = ""
}
# @hidden
variable "seal_metadata_project_name" {
  type        = string
  description = "Seal metadata project name."
  default     = ""
}
# @hidden
variable "seal_metadata_module_name" {
  type        = string
  description = "Seal metadata module name."
  default     = ""
}
