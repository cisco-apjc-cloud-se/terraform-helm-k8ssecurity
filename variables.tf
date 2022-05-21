### Helm Variables ###
variable "sca" {
  type = object({
    enabled         = bool
    kubernetes      = object({
      namespace     = string
      })
    helm            = object({
      release_name  = string
      repository    = optional(string)
      chart_name    = optional(string) # name or URL
      chart_url     = optional(string)
      chart_version = optional(string)
      service_key   = string
      })

    })
}
