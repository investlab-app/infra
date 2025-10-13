# Call all modules
module "kubernetes" {
  source = "./modules/kubernetes"

  providers = {
    kubernetes = kubernetes
  }

  kubernetes_namespace = var.kubernetes_namespace
  docker_server        = var.docker_server
  docker_username      = var.docker_username
  docker_password      = var.docker_password
  docker_email         = var.docker_email
}

module "cert_manager" {
  source = "./modules/cert-manager"

  providers = {
    kubernetes = kubernetes
    helm       = helm
    kubectl    = kubectl
  }

  kubernetes_namespace = var.kubernetes_namespace
  cert_manager_email   = var.cert_manager_email

  depends_on = [
    module.kubernetes
  ]
}

module "database" {
  source = "./modules/database"

  providers = {
    kubernetes = kubernetes
    helm       = helm
    kubectl    = kubectl
  }

  kubernetes_namespace     = var.kubernetes_namespace
  postgresql_storage_class = var.postgresql_storage_class
  postgres_user            = var.postgres_user
  postgres_db              = var.postgres_db
  postgres_password        = var.postgres_password

  depends_on = [
    module.kubernetes,
    module.cert_manager
  ]
}

module "cache" {
  source = "./modules/cache"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }

  kubernetes_namespace = var.kubernetes_namespace
  redis_storage_class  = var.redis_storage_class
  redis_password       = var.redis_password

  depends_on = [
    module.kubernetes,
    module.cert_manager
  ]
}

module "application" {
  source = "./modules/application"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }

  kubernetes_namespace = var.kubernetes_namespace
  config = {
    docker = {
      server = var.docker_server
      auth   = module.kubernetes.docker_config_secret
    }
    database = {
      host     = module.database.database_host
      name     = var.postgres_db
      user     = var.postgres_user
      password = var.postgres_password
    }
    redis = {
      host     = module.cache.redis_host
      password = var.redis_password
    }
    django = {
      secret_key    = var.secret_key
      allowed_hosts = var.allowed_hosts
      debug         = var.debug
      log_level     = var.django_log_level
    }
    cors = {
      allowed_origins      = var.cors_allowed_origins
      csrf_trusted_origins = var.csrf_trusted_origins
    }
    auth = {
      clerk_secret_key = var.clerk_secret_key
      clerk_issuer     = var.clerk_issuer
      clerk_jwks_url   = var.clerk_jwks_url
      clerk_jwt_key    = var.clerk_jwt_key
    }
    apis = {
      polygon_secret_key = var.polygon_secret_key
      alpaca_public_key  = var.alpaca_public_key
      alpaca_secret_key  = var.alpaca_secret_key
    }
    email = {
      admin_email = var.admin_email
      from_email  = var.from_email
      backend     = var.email_backend
      file_path   = var.email_file_path
    }
    vapid = {
      private_key = var.vapid_private_key
      public_key  = var.vapid_public_key
    }
    ingress = {
      host = var.ingress_host
    }
  }
  letsencrypt_issuer = module.cert_manager.letsencrypt_issuer

  depends_on = [
    module.kubernetes,
    module.cert_manager,
    module.database,
    module.cache
  ]
}
