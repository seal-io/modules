variable "namespace" {
  type        = string
  description = "(Optional) namespace to deploy"
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
}
variable init_db_script {
  type = string
  description = "(Optional) Init db scripts "
  default = null
}