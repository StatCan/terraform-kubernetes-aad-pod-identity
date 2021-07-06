resource "helm_release" "aad-pod-identity" {
  name = "mic-aad-pod-identity"

  repository          = var.helm_repository
  repository_username = var.helm_repository_username
  repository_password = var.helm_repository_password

  chart     = "aad-pod-identity"
  version   = var.chart_version
  namespace = var.helm_namespace
  timeout   = 1200

  values = [
    var.values,
  ]

  # Credentials

  set {
    name  = "azureIdentity.resourceID"
    value = var.resource_id
  }

  set {
    name  = "azureIdentity.clientID"
    value = var.client_id
  }

}