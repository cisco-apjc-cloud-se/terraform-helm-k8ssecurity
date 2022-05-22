### Kubernetes  ###

resource "kubernetes_namespace" "sca" {
  metadata {
    annotations = {
      name =var.namespace
    }
    labels = {
      "app.kubernetes.io/name" = var.namespace
    }
    name = var.namespace
  }
}

### Helm ###

## Add Secure Cloud Analytics - K8S Agent Release ##
resource "helm_release" "sca" {
 namespace   = kubernetes_namespace.sca.metadata[0].name
 name        = var.release_name
 repository  = var.repository
 chart       = var.chart_url != null ? var.chart_url : var.chart_name  ## Repo & Url?
 version     = var.chart_version

 set {
   name  = "sca.service_key"
   value = var.service_key
 }
}
