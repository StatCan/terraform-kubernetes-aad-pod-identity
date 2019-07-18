variable "helm_service_account" {}
variable "helm_namespace" {}

variable "chart_version" {}

# Credentials

variable "resource_id" {}

variable "client_id" {}

variable "dependencies" {
  type = "list"
}
