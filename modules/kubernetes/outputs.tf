output "kubernetes_namespace" {
  value = kubernetes_namespace_v1.app_namespace.metadata[0].name
}

output "docker_config_secret" {
  value = kubernetes_secret_v1.docker_config.metadata[0].name
}
