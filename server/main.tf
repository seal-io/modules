resource "ssh_resource" "server" {
  host        = var.host
  port        = var.port
  user        = var.user
  password    = var.password

  timeout = "3m"
  retry_delay = "5s"
}

variable "host" {
  sensitive   = false
  type        = string
  description = "SSH host"
}

variable "port" {
  sensitive   = false
  type        = number
  description = "SSH port"
  default     = 22
}

variable "user" {
  sensitive   = false
  type        = string
  description = "SSH user"
  default     = "root"
}

variable "password" {
  sensitive   = true
  type        = string
  description = "SSH password"
}

output "host" {
  value = var.host
  description = "SSH host"
}

output "port" {
  value = var.port
  description = "SSH port"
}

output "user" {
  value = var.user
  description = "SSH user"
}

output "password" {
  value       = var.password
  sensitive   = true
  description = "SSH password"
}