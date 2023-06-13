##############
# Basic Group
##############

# @group "Basic"
# @label "Engine"
# @options ["MySQL-5.7","MySQL-8.0","MariaDB-10.3","PostgreSQL-13","PostgreSQL-14","PostgreSQL-15"]
variable "engine" {
  type        = string
  description = "Select the RDS engine, support serval kinds of 'MySQL', 'MariaDB' and 'PostgreSQL'."

  validation {
    condition     = contains(["MySQL-5.7", "MySQL-8.0", "MariaDB-10.3", "PostgreSQL-13", "PostgreSQL-14", "PostgreSQL-15"], var.engine)
    error_message = "Invalid engine"
  }
}

# @group "Basic"
# @label "Architecture"
# @options ["Standalone","Replication"]
variable "architecture" {
  type        = string
  description = "Select the RDS architecture, support from 'Standalone' and 'Replication', 'MariaDB' engine doesn't support 'Standalone'."

  validation {
    condition     = contains(["Standalone", "Replication"], var.architecture)
    error_message = "Invalid architecture"
  }
}

# @group "Basic"
# @label "Password"
variable "password" {
  type        = string
  description = "Specify the root password to initialize after launching."

  validation {
    condition     = var.password != "" ? can(regex("^[A-Za-z0-9\\!#\\$%\\^&\\*\\(\\)_\\+\\-=]{8,32}", var.password)) : true
    error_message = "Invalid password"
  }
}

# @group "Basic"
# @label "Username"
variable "username" {
  type        = string
  description = "Specify the root username to initialize after launching, do not allow 'root' and 'sa'."
  default     = "rdsusr"

  validation {
    condition     = !contains(["root", "sa"], var.username)
    error_message = format("Invalid username: %s", var.username)
  }

  validation {
    condition     = can(regex("^[^pg][a-z][a-z0-9_]{0,61}[a-z0-9]$", var.username))
    error_message = format("Invalid username: %s", var.username)
  }
}

# @group "Basic"
# @label "Database"
variable "database" {
  type        = string
  description = "Specify the database name to initialize after launching."
  default     = "rdsdb"

  validation {
    condition     = can(regex("^[a-z][-a-z0-9_]{0,61}[a-z0-9]$", var.database))
    error_message = format("Invalid database: %s", var.database)
  }
}

#################
# Advanced Group
#################

# @group "Advanced"
# @label "Instance Type"
variable "instance_type" {
  type        = string
  description = "Specify the instance type to deploy the RDS engine, pick at least 2C4G type automatically if empty."
  default     = ""
}

# @group "Advanced"
# @label "Storage Type"
variable "storage_type" {
  type        = string
  description = "Specify the storage type to deploy the RDS engine, pick at least ESSD PL1 if empty."
  default     = ""
}

# @group "Advanced"
# @label "Init SQL URL"
variable "init_sql_url" {
  type        = string
  description = "Specify the init SQL download URL to initialize after launching."
  default     = ""

  validation {
    condition     = var.init_sql_url != "" ? can(regex("^(?:https?://)+(?:[^/.\\s]+\\.)*", var.init_sql_url)) : true
    error_message = "Invalid init sql url"
  }
}

# @group "Advanced"
# @label "Publicly Accessible"
variable "publicly_accessible" {
  type        = string
  description = "Specify to allow publicly accessing."
  default     = false
}

# @group "Advanced"
# @label "VPC ID"
variable "vpc_id" {
  type        = string
  description = "Specify the existing VPC ID to deploy, create a new one if empty."
  default     = ""
}

###########################
# Injection Group (Hidden)
###########################

# @hidden
variable "seal_metadata_project_name" {
  type        = string
  description = "Seal metadata project name."
  default     = ""
}

# @hidden
variable "seal_metadata_environment_name" {
  type        = string
  description = "Seal metadata environment name."
  default     = ""
}

# @hidden
variable "seal_metadata_service_name" {
  type        = string
  description = "Seal metadata service name."
  default     = ""
}
