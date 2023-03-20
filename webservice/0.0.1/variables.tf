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
  default = [80]
}
# @label "Environment Variables"
# @group "Basic"
variable "env" {
  type        = map(string)
  description = "Name and value pairs to set as the environment variables"
  default     = {}
}
# @group "Resources"
# @label "CPU"
# @options ["0.5","1","2"]
variable "cpu" {
  type        = string
  description = "CPU"
  default = "0.5"
}
# @group "Resources"
# @label "Memory"
# @options ["1Gi","2Gi","4Gi"]
variable "memory" {
  type        = string
  description = "Memory"
  default = "512Mi"
}
# @label "Namespace"
# @group "Advanced"
variable "namespace" {
  type        = string
  description = "Namespace to deploy. Auto-generated if empty."
  default = ""
}
# @label "Deployment Name"
# @group "Advanced"
variable "name" {
  type        = string
  description = "Name of the deployment resource. Auto-generated if empty."
  default = ""
}