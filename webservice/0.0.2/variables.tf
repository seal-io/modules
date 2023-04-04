# @label "Image Name"
# @group "Basic"
variable "image" {
  type        = string
  description = "Docker image name"
}
# @label "Ports"
# @group "Basic"
variable "ports" {
  type        = list(number)
  description = "Service ports to expose"
  default     = [80]
}
# @label "Environment Variables"
# @group "Basic"
variable "env" {
  type        = map(string)
  description = "Name and value pairs to set as the environment variables"
  default     = {}
}
# @group "Resources"
# @label "CPU Request"
variable "request_cpu" {
  type        = string
  description = "CPU request. e.g. 0.5, 1, 2"
  default     = "0.1"
}
# @group "Resources"
# @label "Memory Request"
variable "request_memory" {
  type        = string
  description = "Memory request. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi"
  default     = "128Mi"
}
# @group "Resources"
# @label "CPU Limit"
variable "limit_cpu" {
  type        = string
  description = "CPU limit. e.g. 0.5, 1, 2"
  default     = ""
}
# @group "Resources"
# @label "Memory Limit"
variable "limit_memory" {
  type        = string
  description = "Memory limit. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi"
  default     = ""
}
# @label "Create namespace"
# @group "Advanced"
variable "create_namespace" {
  type        = bool
  description = "Create namespace. Default 'true' value will create namespace in cluster. If you want use exist namespace set 'false'"
  default     = true
}
# @label "Namespace"
# @group "Advanced"
variable "namespace" {
  type        = string
  description = "Namespace to deploy. Auto-generated if empty."
  default     = ""
}
# @label "Deployment Name"
# @group "Advanced"
variable "name" {
  type        = string
  description = "Name of the deployment resource. Auto-generated if empty."
  default     = ""
}
