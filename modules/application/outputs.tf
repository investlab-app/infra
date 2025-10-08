output "application_release" {
  value = helm_release.investlab_app.metadata[0].name
}
