terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17"
    }
  }
}

locals {
  common_labels = {
    project    = "investlab"
    managed-by = "terraform"
  }
}

resource "kubernetes_deployment_v1" "redis" {
  metadata {
    name      = "redis"
    namespace = var.kubernetes_namespace
    labels = merge(local.common_labels, {
      "component" = "redis"
      "app"       = "redis"
    })
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "redis"
      }
    }

    template {
      metadata {
        labels = {
          app = "redis"
        }
      }

      spec {
        container {
          image = "redis:7.2.4"
          name  = "redis"

          port {
            container_port = 6379
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }

          volume_mount {
            mount_path = "/data"
            name       = "redis-storage"
          }

          command = ["redis-server"]
          args    = ["--requirepass", "$(REDIS_PASSWORD)", "--appendonly", "yes"]

          env {
            name = "REDIS_PASSWORD"
            value_from {
              secret_key_ref {
                name = "redis-credentials"
                key  = "password"
              }
            }
          }
        }

        volume {
          name = "redis-storage"
          empty_dir {}
        }
      }
    }
  }

  depends_on = [
    var.kubernetes_namespace,
    kubernetes_secret_v1.redis_credentials
  ]
}

resource "kubernetes_service_v1" "redis" {
  metadata {
    name      = "redis"
    namespace = var.kubernetes_namespace
    labels = merge(local.common_labels, {
      "component" = "redis"
    })
  }

  spec {
    selector = {
      app = "redis"
    }

    port {
      port        = 6379
      target_port = 6379
    }

    type = "ClusterIP"
  }

  depends_on = [
    var.kubernetes_namespace,
    kubernetes_deployment_v1.redis
  ]
}

output "redis_status" {
  value      = "Redis installed at ${timestamp()}"
  depends_on = [kubernetes_deployment_v1.redis]
}

resource "kubernetes_secret_v1" "redis_credentials" {
  metadata {
    name      = "redis-credentials"
    namespace = var.kubernetes_namespace
    labels = merge(local.common_labels, {
      "component" = "redis"
    })
  }

  type = "Opaque"

  data = {
    password = var.redis_password
  }

  depends_on = [
    var.kubernetes_namespace
  ]
}
