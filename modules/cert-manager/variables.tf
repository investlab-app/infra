variable "kubernetes_namespace" {
  description = "Kubernetes namespace"
  type        = string
}

variable "cert_manager_email" {
  description = "Email for Let's Encrypt certificate"
  type        = string
}
