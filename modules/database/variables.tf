variable "kubernetes_namespace" {
  description = "Kubernetes namespace"
  type        = string
}

variable "postgresql_storage_class" {
  description = "Storage class for PostgreSQL"
  type        = string
  default     = "default"
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
