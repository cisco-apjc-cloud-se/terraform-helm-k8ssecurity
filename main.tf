terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
  experiments = [module_variable_optional_attrs]
}

### Secure Cloud Analytics ###
locals {
  ## Set Default Values
  sca = defaults(var.sca, {
    enabled = false
    })
}

module "sca" {
  source = "./modules/sca"
  count = local.sca.enabled == true ? 1 : 0

  ### Kubernetes Settings ###
  namespace     = local.sca.kubernetes.namespace

  ### Helm Setttings ###
  repository    = local.sca.helm.repository
  release_name  = local.sca.helm.release_name
  chart_name    = local.sca.helm.chart_name
  chart_version = local.sca.helm.chart_version
  chart_url     = local.sca.helm.chart_url
  service_key   = local.sca.helm.service_key

}
