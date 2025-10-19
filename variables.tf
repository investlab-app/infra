# Kubernetes
variable "kubernetes_cluster_ca_certificate" {
  description = "Kubernetes cluster CA certificate"
  type        = string
}

variable "kubernetes_namespace" {
  description = "Kubernetes namespace"
  type        = string
}

variable "kubernetes_host" {
  description = "The hostname (or IP address) of the Kubernetes API server"
  type        = string
}

variable "kubernetes_token" {
  description = "Bearer token for authenticating with the Kubernetes API"
  type        = string
  sensitive   = true
}


# Oracle
variable "oke_cluster_ocid" {
  description = "The OCID of the OKE cluster"
  type        = string
}


# Docker Registry
variable "docker_server" {
  description = "Docker registry server"
  type        = string
}

variable "docker_username" {
  description = "Docker registry username"
  type        = string
}

variable "docker_password" {
  description = "Docker registry password"
  type        = string
  sensitive   = true
}

variable "docker_email" {
  description = "Docker registry email"
  type        = string
}


# PostgreSQL
variable "postgresql_storage_class" {
  description = "Storage class for PostgreSQL"
  type        = string
}

variable "postgres_user" {
  description = "PostgreSQL user"
  type        = string
}

variable "postgres_db" {
  description = "PostgreSQL database"
  type        = string
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}

variable "postgres_port" {
  description = "PostgreSQL port"
  type        = number
  default     = 5432
}


# Redis
variable "redis_storage_class" {
  description = "Storage class for Redis"
  type        = string
}

variable "redis_host" {
  description = "Redis host"
  type        = string
  default     = "redis-master"
}

variable "redis_port" {
  description = "Redis port"
  type        = number
  default     = 6379
}

variable "redis_password" {
  description = "Redis password"
  type        = string
  sensitive   = true
}

# Cert manager
variable "cert_manager_email" {
  description = "Email for Let's Encrypt certificate"
  type        = string
  default     = "admin@investlab.kapica.click"
}


# Ingress
variable "ingress_host" {
  description = "Ingress host"
  type        = string
}


# Clerk (auth)
variable "clerk_secret_key" {
  description = "Clerk secret key"
  type        = string
  sensitive   = true
}

variable "clerk_issuer" {
  description = "Clerk issuer URL"
  type        = string
}

variable "clerk_jwks_url" {
  description = "Clerk JWKS URL"
  type        = string
}

variable "clerk_jwt_key" {
  description = "Clerk JWT public key"
  type        = string
}


# APIs
variable "polygon_secret_key" {
  description = "Polygon secret key"
  type        = string
  sensitive   = true
}

variable "alpaca_public_key" {
  description = "Alpaca public key"
  type        = string
}

variable "alpaca_secret_key" {
  description = "Alpaca secret key"
  type        = string
  sensitive   = true
}


# Container images
variable "backend_image" {
  description = "Backend Docker image"
  type        = string
  default     = "ghcr.io/investlab-app/backend:latest"
}

variable "frontend_image" {
  description = "Frontend Docker image"
  type        = string
  default     = "ghcr.io/investlab-app/web:latest"
}


# Django
variable "django_log_level" {
  description = "Django log level"
  type        = string
  default     = "INFO"
}

variable "debug" {
  description = "Django DEBUG setting"
  type        = bool
  default     = false
}

variable "secret_key" {
  description = "Django SECRET_KEY"
  type        = string
  sensitive   = true
}

variable "allowed_hosts" {
  description = "Django ALLOWED_HOSTS"
  type        = string
  default     = "*"
}

variable "cors_allowed_origins" {
  description = "CORS allowed origins"
  type        = string
  default     = ""
}

variable "csrf_trusted_origins" {
  description = "CSRF trusted origins"
  type        = string
  default     = ""
}


# Email
variable "admin_email" {
  description = "Admin email"
  type        = string
}

variable "from_email" {
  description = "From email"
  type        = string
}

variable "email_backend" {
  description = "Email backend"
  type        = string
  default     = "django.core.mail.backends.locmem.EmailBackend"
}

variable "email_file_path" {
  description = "Email file path"
  type        = string
  default     = "/tmp/app-emails"
}


# Vapid
variable "vapid_private_key" {
  description = "VAPID private key"
  type        = string
  sensitive   = true
}

variable "vapid_public_key" {
  description = "VAPID public key"
  type        = string
}