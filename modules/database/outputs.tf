output "database_host" {
  value = "${kubectl_manifest.postgresql_cluster.name}-rw"
}
