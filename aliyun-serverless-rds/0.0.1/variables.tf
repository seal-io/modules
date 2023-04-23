variable "instance_name" {
  description = "数据库实例名称"
  default = "seal-demo-serverless"
}

variable "db_name" {
  description = "数据库名称"
  default = "demodb"
}

variable "allocate_public_connection" {
  description = "是否开通数据库互联网访问"
  type    = bool
  default = true
}
