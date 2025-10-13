variable "config" {
  description = "Application configuration"
  type = object({
    docker = object({
      server = string
      auth   = string
    })
    database = object({
      host     = string
      name     = string
      user     = string
      password = string
    })
    redis = object({
      host     = string
      password = string
    })
    django = object({
      secret_key    = string
      allowed_hosts = optional(string, "*")
      debug         = optional(bool, false)
      log_level     = optional(string, "INFO")
    })
    cors = object({
      allowed_origins      = optional(string, "http://localhost:3000,http://localhost:8000")
      csrf_trusted_origins = optional(string, "")
    })
    auth = object({
      clerk_secret_key = string
      clerk_issuer     = string
      clerk_jwks_url   = string
      clerk_jwt_key    = string
    })
    apis = object({
      polygon_secret_key = string
      alpaca_public_key  = string
      alpaca_secret_key  = string
    })
    email = object({
      admin_email = string
      from_email  = string
      backend     = optional(string, "django.core.mail.backends.locmem.EmailBackend")
      file_path   = optional(string, "/tmp/app-emails")
    })
    vapid = object({
      private_key = string
      public_key  = string
    })
    ingress = object({
      host = string
    })
  })
  sensitive = true
}

variable "kubernetes_namespace" {
  description = "Kubernetes namespace"
  type        = string
}

variable "letsencrypt_issuer" {
  description = "Let's Encrypt cluster issuer"
  type        = string
}
