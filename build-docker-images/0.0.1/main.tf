terraform {
  required_providers {
    kaniko = {
      source  = "gitlawr/kaniko"
      version = "0.0.1-dev1"
    }
  }
}

resource "kaniko_image" "image" {
  # Only handle git context. Explicitly use the git scheme.
  context     = replace(var.git_url, "https://", "git://")
  dockerfile  = var.dockerfile
  destination = var.image

  git_username      = var.git_auth ? var.git_username : ""
  git_password      = var.git_auth ? var.git_password : ""
  registry_username = var.registry_auth ? var.registry_username : ""
  registry_password = var.registry_auth ? var.registry_password : ""
}
