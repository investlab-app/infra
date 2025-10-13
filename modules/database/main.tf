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
    kubectl = {
      source = "gavinbunney/kubectl"

      version = "~> 1.19"
    }
  }
}

locals {
  common_labels = {
    project    = "investlab"
    managed-by = "terraform"
  }
}

resource "kubernetes_secret_v1" "postgresql_credentials" {
  metadata {
    name      = "postgresql-credentials"
    namespace = var.kubernetes_namespace
    labels = merge(local.common_labels, {
      component = "postgresql"
    })
  }

  data = {
    username = var.postgres_user
    password = var.postgres_password
  }
}

resource "helm_release" "cloudnativepg" {
  name       = "cloudnativepg"
  repository = "https://cloudnative-pg.github.io/charts"
  chart      = "cloudnative-pg"
  version    = "0.21.5"
  namespace  = var.kubernetes_namespace

  wait          = true
  wait_for_jobs = true
  timeout       = 600
}

resource "kubectl_manifest" "postgresql_cluster" {
  yaml_body = yamlencode({
    apiVersion = "postgresql.cnpg.io/v1"
    kind       = "Cluster"
    metadata = {
      name      = "postgresql-cluster"
      namespace = var.kubernetes_namespace
      labels = merge(local.common_labels, {
        component = "postgresql"
      })
    }
    spec = {
      instances = 3

      bootstrap = {
        initdb = {
          database = var.postgres_db
          owner    = var.postgres_user
          secret = {
            name = kubernetes_secret_v1.postgresql_credentials.metadata[0].name
          }
        }
      }

      storage = {
        size         = "5Gi"
        storageClass = var.postgresql_storage_class
      }
    }
  })

  depends_on = [
    helm_release.cloudnativepg,
    kubernetes_secret_v1.postgresql_credentials
  ]
}
