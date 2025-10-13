output "kubernetes_namespace" {
  value = module.kubernetes.kubernetes_namespace
}

output "app_ingress_url" {
  value = "https://${var.ingress_host}"
}

output "database_host" {
  value = module.database.database_host
}

output "redis_host" {
  value = module.cache.redis_host
}
