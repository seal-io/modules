# @group "Kubernetes Configuration"
# @label "命名空间"
variable "namespace" {
  description = "Namespace to deploy"
  type        = string 
}

# @group "Image Configuration"
# @label "镜像仓库地址"
variable "image_registry" {
  description = "Image Registry"
  type        = string
  default     = "docker.io"
}


# @group "Image Configuration"
# @label "镜像仓库项目"
variable "image_repository" {
  description = "Image Repository"
  type        = string
  default     = "liyinlin"
}
