variable "deployment_name" {
  type = string
}

variable "image_name" {
  type = string
}

variable "replicas" {
  type = number
}

resource "kubernetes_deployment" "example" {
  metadata {
    name = var.deployment_name
  }

  spec {
    selector {
      match_labels = {
        app = var.deployment_name
      }
    }

    replicas = var.replicas

    template {
      metadata {
        labels = {
          app = var.deployment_name
        }
      }

      spec {
        container {
          image = var.image_name
          name  = var.deployment_name
        }
      }
    }
  }
}