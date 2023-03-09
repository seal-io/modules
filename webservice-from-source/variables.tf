# @label "Git URL"
# @group "Source"
variable "git_url" {
  type        = string
  description = "URL to the source code repository."
}
# @label "Git Branch"
# @group "Source"
variable "git_branch" {
  type        = string
  default = "main"
  description = "Branch of the repository to clone."
}
# @label "Authentication"
# @group "Source"
variable "git_auth" {
  type        = bool
  default = false
}
# @label "Username"
# @group "Source"
# @show_if "git_auth=true"
variable "git_username" {
  type        = string
  default = null
  sensitive = true
  description = "Username for cloning the git repository."
}
# @label "Password"
# @group "Source"
# @show_if "git_auth=true"
variable "git_password" {
  type        = string
  default = null
  sensitive = true
  description = "Password for cloning the git repository."
}
# @label "Sub Path"
# @group "Source"
variable "git_path" {
  type        = string
  default     = null
  description = "Path to the source code."
}

# @label "Dockerfile Path"
# @group "Build"
variable "dockerfile" {
  type        = string
  default = "Dockerfile"
  description = "Path to the Dockerfile."
}
# @label "Image Name"
# @group "Build"
variable "image" {
  type        = string
  description = "Name of the image to be built and deployed."
}
# @label "Registry Authentication"
# @group "Build"
variable "registry_auth" {
  type        = bool
  default = false
}
# @label "Username"
# @group "Build"
# @show_if "registry_auth=true"
variable "registry_username" {
  type        = string
  default = null
  sensitive = true
  description = "Username for the image registry."
}
# @label "Password"
# @group "Build"
# @show_if "registry_auth=true"
variable "registry_password" {
  type        = string
  default = null
  sensitive = true
  description = "Password for the image registry."
}

# @label "Deployment Name"
# @group "Deploy"
variable "name" {
  type        = string
  description = "Deployment name"
}
# @label "Namespace"
# @group "Deploy"
variable "namespace" {
  type        = string
  description = "namespace"
  default = "default"
}
# @label "Port"
# @group "Deploy"
variable "port" {
  type        = list(number)
  description = "Service ports"
  default = [80]
}
# @label "CPU"
# @group "Deploy"
variable "cpu" {
  type        = string
  description = "(Optional) CPU"
  default = "0.5"
}
# @label "Memory"
# @group "Deploy"
variable "memory" {
  type        = string
  description = "(Optional) Memory"
  default = "512Mi"
}
# @label "Environment Variables"
# @group "Deploy"
variable "env" {
  type        = map(string)
  description = "(Optional) Name and value pairs to set as the environment variables"
  default     = {}
}
