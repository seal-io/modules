# @label "Database Name"
# @group "Basic"
variable "database" {
  type        = string
  description = "Database name"
  default     = "mysql"
}
# @label "Username"
# @group "Basic"
variable "username" {
  type        = string
  description = "Username"
  default     = "mysql"
}
# @label "Password"
# @group "Basic"
variable "password" {
  type        = string
  description = "Password. Auto-generated if empty."
  default     = ""
}
# @label "Namespace"
# @group "Advanced"
variable "namespace" {
  type        = string
  description = "Namespace to deploy. Auto-generated if empty."
  default     = ""
}
# @label "Init DB Scripts"
# @group "Advanced"
variable "init_db_script" {
  type        = string
  description = "Init db scripts."
  default     = ""
}
# @hidden
variable "seal_metadata_service_name" {
  type        = string
  description = "Seal metadata service name."
  default     = ""
}
# @hidden
variable "seal_metadata_environment_name" {
  type        = string
  description = "Seal metadata environment name."
  default     = ""
}
# @hidden
variable "seal_metadata_project_name" {
  type        = string
  description = "Seal metadata project name."
  default     = ""
}
