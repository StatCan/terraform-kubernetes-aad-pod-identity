variable "helm_namespace" {}

variable "helm_repository" {}
variable "helm_repository_password" {
  default = ""
}
variable "helm_repository_username" {
  default = ""
}

variable "chart_version" {}

# Credentials

variable "resource_id" {}

variable "client_id" {}

variable "values" {
  default = ""
  type    = string
}
