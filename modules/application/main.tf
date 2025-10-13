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

# Create Kubernetes secret for sensitive values
resource "kubernetes_secret" "app_secrets" {
  metadata {
    name      = "investlab-app-secrets"
    namespace = var.kubernetes_namespace
    labels    = local.common_labels
  }

  type = "Opaque"

  data = {
    # Database credentials
    database-password = var.config.database.password
    database-user     = var.config.database.user
    database-url      = "postgres://${var.config.database.user}:${var.config.database.password}@${var.config.database.host}:5432/${var.config.database.name}"

    # Redis credentials
    redis-password = var.config.redis.password

    # Django settings
    django-secret-key = var.config.django.secret_key

    # Clerk authentication
    clerk-secret-key = var.config.auth.clerk_secret_key
    clerk-jwt-key    = var.config.auth.clerk_jwt_key

    # API keys
    polygon-secret-key = var.config.apis.polygon_secret_key
    alpaca-secret-key  = var.config.apis.alpaca_secret_key
    alpaca-public-key  = var.config.apis.alpaca_public_key

    # VAPID keys
    vapid-private-key = var.config.vapid.private_key
  }
}

resource "helm_release" "investlab_app" {
  name      = "investlab-app"
  namespace = var.kubernetes_namespace
  chart     = "${path.root}/helm/investlab-app"
  version   = "0.1.0"

  values = [
    templatefile("${path.root}/templates/app-values.yaml.tftpl", {
      global = {
        imageRegistry    = var.config.docker.server
        imagePullSecrets = [var.config.docker.auth]
      }

      env = {
        database = {
          host = var.config.database.host
          port = 5432
          name = var.config.database.name
          # Remove sensitive values - they will be loaded from secrets
        }

        redis = {
          host = var.config.redis.host
          port = 6379
          # Remove sensitive values - they will be loaded from secrets
        }

        django = {
          logLevel = var.config.django.log_level
          debug    = var.config.django.debug
          # Remove secretKey - it will be loaded from secrets
          allowedHosts = var.config.django.allowed_hosts
        }

        cors = {
          allowedOrigins     = var.config.cors.allowed_origins
          csrfTrustedOrigins = var.config.cors.csrf_trusted_origins
        }

        clerk = {
          # Remove sensitive values - they will be loaded from secrets
          issuer  = var.config.auth.clerk_issuer
          jwksUrl = var.config.auth.clerk_jwks_url
        }

        apis = {
          # Remove sensitive values - they will be loaded from secrets
        }

        email = {
          adminEmail = var.config.email.admin_email
          fromEmail  = var.config.email.from_email
          backend    = var.config.email.backend
          filePath   = var.config.email.file_path
        }

        vapid = {
          # Remove sensitive values - they will be loaded from secrets
          publicKey = var.config.vapid.public_key
        }
      }

      ingress = {
        host = var.config.ingress.host
      }
    })
  ]

  depends_on = [
    var.kubernetes_namespace,
    var.letsencrypt_issuer,
    kubernetes_secret.app_secrets
  ]
}
