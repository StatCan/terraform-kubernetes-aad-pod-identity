# Terraform Kubernetes AAD Pod Identity

## Introduction

This module deploys and configures Azure Active Directory Pod Identity into a Kubernetes Cluster.

## Security Controls

The following security controls can be met through configuration of this template:

* TBD

## Dependancies

* None

## Usage

```terraform
module "helm_aad_pod_identity" {
  source = "github.com/canada-ca-terraform-modules/terraform-kubernetes-aad-pod-identity?ref=20190909.1"

  chart_version = "0.0.1"
  dependencies = [
    "${module.namespace_default.depended_on}",
  ]

  helm_service_account = "tiller"
  helm_namespace = "default"
  helm_repository = "stable"

  resource_id = "/subscriptions/<subscription_id>/resourceGroups/<resource_group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<named_identity>"
  client_id = "<client_id>"

  values = <<EOF

EOF
}
```

## Variables Values

| Name                 | Type   | Required | Value                                               |
| -------------------- | ------ | -------- | --------------------------------------------------- |
| chart_version        | string | yes      | Version of the Helm Chart                           |
| dependencies         | string | yes      | Dependency name refering to namespace module        |
| helm_service_account | string | yes      | The service account for Helm to use                 |
| helm_namespace       | string | yes      | The namespace Helm will install the chart under     |
| helm_repository      | string | yes      | The repository where the Helm chart is stored       |
| resource_id          | string | yes      | The resource id to be used for the Managed Identity |
| client_id            | string | yes      | The client id to be used for the Managed Identity   |
| values               | list   | no       | Values to be passed to the Helm Chart               |

## History

| Date     | Release    | Change      |
| -------- | ---------- | ----------- |
| 20190909 | 20190909.1 | 1st release |
