variable "helm_namespace" {
  default = "default"
}

variable "helm_repository" {
  default = "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"
}

variable "helm_repository_password" {
  default = ""
}
variable "helm_repository_username" {
  default = ""
}

variable "chart_version" {
  default = "3.0.3"
}

# Credentials

variable "resource_id" {
  default = ""
}

variable "client_id" {
  default = ""
}

variable "values" {
  default = ""
}
