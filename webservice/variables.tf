variable "name" {
  type        = string
  description = "(Required) App instance name"
}
variable "image" {
  type        = string
  description = "(Required) Docker image name"
}
variable "namespace" {
  type        = string
  description = "(Optional) namespace"
  default = "default"
}
variable "port" {
  type        = list(number)
  description = "(Optional) Service ports"
  default = [80]
}
variable "cpu" {
  type        = string
  description = "(Optional) CPU"
  default = "0.5"
}
variable "memory" {
  type        = string
  description = "(Optional) Memory"
  default = "512Mi"
}
variable "env" {
  type        = map(string)
  description = "(Optional) Name and value pairs to set as the environment variables"
  default     = {}
}