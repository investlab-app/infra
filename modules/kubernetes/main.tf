terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35"
    }
  }
}

locals {
  common_labels = {
    project    = "investlab"
    managed-by = "terraform"
  }
}

resource "kubernetes_namespace_v1" "app_namespace" {
  metadata {
    name = var.kubernetes_namespace
    labels = merge(local.common_labels, {
      "name" = var.kubernetes_namespace
    })
  }
}

resource "kubernetes_secret_v1" "docker_config" {
  metadata {
    name      = "docker-config"
    namespace = var.kubernetes_namespace
    labels = merge(local.common_labels, {
      "component" = "docker-config"
    })
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        (var.docker_server) = {
          "username" = var.docker_username
          "password" = var.docker_password
          "email"    = var.docker_email
          "auth"     = base64encode("${var.docker_username}:${var.docker_password}")
        }
      }
    })
  }
}
