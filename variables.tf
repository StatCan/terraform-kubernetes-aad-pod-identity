variable "helm_namespace" {}

variable "helm_repository" {}

variable "chart_version" {}

# Credentials

variable "resource_id" {}

variable "client_id" {}

variable "dependencies" {
  type = "list"
}

variable "values" {
  default = ""
  type    = "string"
}
