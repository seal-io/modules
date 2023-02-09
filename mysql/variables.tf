variable "name" {
  type        = string
  description = "(Required) App instance name"
}
variable "namespace" {
  type        = string
  description = "(Optional) namespace"
  default = "default"
}
variable "database" {
  type        = string
  description = "(Optional) Database name"
  default = "mysql"
}
variable "username" {
  type        = string
  description = "(Optional) Username"
  default = "mysql"
}
variable "password" {
  type        = string
  description = "(Optional) Password"
  default = "mysql"
  sensitive = true
}
variable init_db_script {
  type = string
  description = "(Optional) Init db scripts "
  default = null
}