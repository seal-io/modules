#################
# RDS Instance
#################
# @group "RDS Instance"
variable "instance_name" {
  description = "The name of DB instance. A random name prefixed with 'terraform-rds-' will be set if it is empty."
  default     = ""
}
# @group "RDS Instance"
# @options ["Postpaid", "Prepaid"]
variable "instance_charge_type" {
  description = "The instance charge type. Valid values: Prepaid and Postpaid. Default to Postpaid."
  default     = "Postpaid"
}
# @group "RDS Instance"
variable "instance_storage" {
  description = "The storage capacity of the instance. Unit: GB. Valid values: 20~6000. The storage capacity increases at increments of 5 GB. For more information, see [Instance Types](https://www.alibabacloud.com/help/doc-detail/26312.htm)."
  type        = number
  default     = 20
}
# @group "RDS Instance"
variable "instance_type" {
  description = "DB Instance type, for example: mysql.n1.micro.1. full list is : https://www.alibabacloud.com/help/zh/doc-detail/26312.htm"
  default     = "mysql.n2.medium.1"
}
# @group "RDS Instance"
variable "security_group_ids" {
  description = "List of VPC security group ids to associate with rds instance."
  type        = list(string)
  default     = ["sg-bp12e0rsb4xq98s579j1"]
}
# @group "RDS Instance"
variable "vswitch_id" {
  description = "The virtual switch ID to launch DB instances in one VPC."
  default     = "vsw-bp12dj1783k6zf5p8d5nz"
}
# @group "RDS Instance"
variable "security_ips" {
  description = " List of IP addresses allowed to access all databases of an instance. The list contains up to 1,000 IP addresses, separated by commas. Supported formats include 0.0.0.0/0, 10.23.12.24 (IP), and 10.23.12.24/24 (Classless Inter-Domain Routing (CIDR) mode. /24 represents the length of the prefix in an IP address. The range of the prefix length is [1,32])."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
# @group "RDS Instance"
variable "tags" {
  description = "A mapping of tags to assign to the rds."
  type        = map(string)
  default     = {}
}
# @group "RDS Instance"
variable "instance_storage_type" {
  description = "The storage type of the instance"
  default     = "cloud_essd"
}
# @group "RDS Instance"
variable "sql_collector_status" {
  description = "The sql collector status of the instance. Valid values are `Enabled`, `Disabled`, Default to `Disabled`."
  type        = string
  default     = "Disabled"
}
# @group "RDS Instance"
variable "sql_collector_config_value" {
  description = "The sql collector keep time of the instance. Valid values are `30`, `180`, `365`, `1095`, `1825`, Default to `30`."
  type        = number
  default     = 30
}

#################
# RDS Backup Policy
#################
# @group "RDS Backup Policy"
variable "preferred_backup_period" {
  description = "DB Instance backup period."
  type        = list(string)
  default     = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
}
# @group "RDS Backup Policy"
variable "preferred_backup_time" {
  description = " DB instance backup time, in the format of HH:mmZ- HH:mmZ. "
  default     = "02:00Z-03:00Z"
}
# @group "RDS Backup Policy"
variable "backup_retention_period" {
  description = "Instance backup retention days. Valid values: [7-730]. Default to 7."
  type        = number
  default     = 7
}
# @group "RDS Backup Policy"
variable "enable_backup_log" {
  description = "Whether to backup instance log. Default to true."
  type        = bool
  default     = true
}
# @group "RDS Backup Policy"
# @show_if "enable_backup_log=true"
variable "log_backup_retention_period" {
  description = "Instance log backup retention days. Valid values: [7-730]. Default to 7. It can be larger than 'retention_period'."
  type        = number
  default     = 7
}

#################
# RDS Connection
#################
# @group "RDS Connection"
variable "allocate_public_connection" {
  description = "Whether to allocate public connection for a RDS instance. If true, the connection_prefix can not be empty."
  type        = bool
  default     = true
}
# @group "RDS Connection"
variable "connection_prefix" {
  description = "Prefix of an Internet connection string. A random name prefixed with 'tf-rds-' will be set if it is empty."
  type        = string
  default     = ""
}
# @group "RDS Connection"
variable "port" {
  description = " Internet connection port. Valid value: [3001-3999]. Default to 3306."
  type        = number
  default     = 3306
}

#################
# RDS Database Account
#################
# @group "RDS Database Account"
# @options [true, false]
variable "create_account" {
  description = "Whether to create a new account. If true, the `account_name` should not be empty."
  type        = bool
  default     = true
}
# @group "RDS Database Account"
# @show_if "create_account=true"
variable "account_name" {
  description = "Name of a new database account. It should be set when create_account = true."
  default     = "demo"
}
# @group "RDS Database Account"
# @show_if "create_account=true"
variable "password" {
  description = "Operation database account password. It may consist of letters, digits, or underlines, with a length of 6 to 32 characters."
  default     = "Seal@123"
}
# @group "RDS Database Account"
# @show_if "create_account=true"
# @options ["Normal", "High privilege"]
variable "type" {
  description = "Privilege type of account. Normal: Common privilege. Super: High privilege. Default to Normal."
  default     = "Normal"
}
# @group "RDS Database Account"
# @show_if "create_account=true"
# @options ["ReadWrite", "ReadOnly"]
variable "privilege" {
  description = "The privilege of one account access database."
  default     = "ReadWrite"
}

#################
# RDS Database
#################
# @group "RDS Database"
variable "create_database" {
  description = "Whether to create multiple databases. If true, the `databases` should not be empty."
  type        = bool
  default     = true
}
# @group "RDS Database"
# @hidden
variable "databases" {
  description = "A list mapping used to add multiple databases. Each item supports keys: name, character_set and description. It should be set when create_database = true."
  type        = list(map(string))
  default     = [
    {
      name          = "demo"
      character_set = "utf8"
      description   = "The demo database."
    },
  ]
}
