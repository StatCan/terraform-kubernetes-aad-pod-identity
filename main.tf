# Part of a hack for module-to-module dependencies.
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
# and
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-473091030
# Make sure to add this null_resource.dependency_getter to the `depends_on`
# attribute to all resource(s) that will be constructed first within this
# module:
resource "null_resource" "dependency_getter" {
  triggers = {
    my_dependencies = "${join(",", var.dependencies)}"
  }
}

resource "null_resource" "wait-dependencies" {
  provisioner "local-exec" {
    command = "helm ls --tiller-namespace ${var.helm_namespace}"
  }

  depends_on = [
    "null_resource.dependency_getter",
  ]
}

# Namespace admin role
resource "kubernetes_role" "tiller-aad-pod-identity" {
  metadata {
    name = "tiller-aad-pod-identity"
    namespace = "${var.helm_namespace}"
  }

  # Read/write access to aad-pod-identity resources
  rule {
    api_groups = ["aadpodidentity.k8s.io"]
    resources = ["*"]
    verbs = ["get", "list", "watch", "create", "update", "patch", "delete", "edit", "exec"]
  }

  depends_on = [
    "null_resource.dependency_getter",
  ]
}

# Namespace admin role bindings
resource "kubernetes_role_binding" "tiller-aad-pod-identity" {
  metadata {
    name = "tiller-aad-pod-identity"
    namespace = "${var.helm_namespace}"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "Role"
    name = "tiller-aad-pod-identity"
  }

  # Users
  subject {
    kind = "ServiceAccount"
    name = "${var.helm_service_account}"
    namespace = "${var.helm_namespace}"
  }
}

resource "helm_release" "aad-pod-identity" {
  depends_on = ["null_resource.wait-dependencies", "null_resource.dependency_getter", "kubernetes_role.tiller-aad-pod-identity", "kubernetes_role_binding.tiller-aad-pod-identity"]
  name = "mic-aad-pod-identity"
  repository = "${var.helm_repository}"
  chart = "aad-pod-identity"
  version = "${var.chart_version}"
  namespace = "${var.helm_namespace}"
  timeout = 1200

  values = [
    "${var.values}",
  ]

  # Credentials

  set {
    name = "azureIdentity.resourceID"
    value = "${var.resource_id}"
  }

  set {
    name = "azureIdentity.clientID"
    value = "${var.client_id}"
  }

}

# Part of a hack for module-to-module dependencies.
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
resource "null_resource" "dependency_setter" {
  # Part of a hack for module-to-module dependencies.
  # https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
  # List resource(s) that will be constructed last within the module.
  depends_on = [
    "helm_release.aad-pod-identity"
  ]
}
