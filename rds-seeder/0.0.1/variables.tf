##############
# Basic Group
##############

# @group "Basic"
# @label "Source"
variable "source_address" {
  type        = string
  description = "Specify the seeding source address started with 'file://' or 'http(s)://' schema."

  validation {
    condition     = can(regex("^(?:(https|http|file)://)+(?:[^/.\\s]+\\.)*", var.source_address))
    error_message = "Invalid source address"
  }
}

# @group "Basic"
# @label "Destination"
variable "destination_address" {
  type        = string
  description = "Specify the seeding destiantion address."
}

#################
# Advanced Group
#################

# @group "Advanced"
# @label "Destination Connection Maximum"
variable "destination_conn_max" {
  type        = number
  description = "Specify the connection maximum value of destination."
  default     = 25
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
