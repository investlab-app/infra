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
          host     = var.config.database.host
          port     = 5432
          name     = var.config.database.name
          user     = var.config.database.user
          password = var.config.database.password
        }

        redis = {
          host     = var.config.redis.host
          port     = 6379
          password = var.config.redis.password
        }

        django = {
          logLevel     = var.config.django.log_level
          debug        = var.config.django.debug
          secretKey    = var.config.django.secret_key
          allowedHosts = var.config.django.allowed_hosts
        }

        cors = {
          allowedOrigins     = var.config.cors.allowed_origins
          csrfTrustedOrigins = var.config.cors.csrf_trusted_origins
        }

        clerk = {
          secretKey = var.config.auth.clerk_secret_key
          issuer    = var.config.auth.clerk_issuer
          jwksUrl   = var.config.auth.clerk_jwks_url
          jwtKey    = var.config.auth.clerk_jwt_key
        }

        apis = {
          polygonSecretKey = var.config.apis.polygon_secret_key
          alpacaPublicKey  = var.config.apis.alpaca_public_key
          alpacaSecretKey  = var.config.apis.alpaca_secret_key
        }

        email = {
          adminEmail = var.config.email.admin_email
          fromEmail  = var.config.email.from_email
          backend    = var.config.email.backend
          filePath   = var.config.email.file_path
        }

        vapid = {
          privateKey = var.config.vapid.private_key
          publicKey  = var.config.vapid.public_key
        }
      }

      ingress = {
        host = var.config.ingress.host
      }
    })
  ]

  depends_on = [
    var.kubernetes_namespace,
    var.letsencrypt_issuer
  ]
}
