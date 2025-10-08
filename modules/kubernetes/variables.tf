variable "kubernetes_namespace" {
  description = "Kubernetes namespace"
  type        = string
}

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
