variable "kubernetes_namespace" {
  description = "Kubernetes namespace"
  type        = string
}

variable "redis_storage_class" {
  description = "Storage class for Redis"
  type        = string
  default     = "default"
}

variable "redis_password" {
  description = "Redis password"
  type        = string
  sensitive   = true
}
