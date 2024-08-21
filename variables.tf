variable "namespace" {
  type        = string
  description = <<-EOT
    Element to ensure resources are generated with names that are globally
    unique and do not collide. This should be a short key such as initials.
    EOT
  nullable    = false
}

variable "environment" {
  type        = string
  default     = ""
  description = <<-EOT
    Element to identify the region and/or the role. If not provided this element
    defaults to <role_short>-<region_short>(-<instance_short>).
    EOT
  nullable    = true
}

variable "role" {
  type        = string
  description = <<-EOT
    A simple name for the hosting provider account or workspace. Included in
    tags to ensure that identification is simple across accounts. Examples
    'production', 'development', 'main'.
    EOT
  nullable    = false
}

variable "role_short" {
  type        = string
  default     = ""
  description = <<-EOT
    Shortened version of the 'role'.
    Automatic shortening is done by removal of vowels unless handled by special
    cases such as 'production' => 'prod', or 'development' => 'dev'.
    EOT
  nullable    = true
}

variable "region" {
  type        = string
  description = <<-EOT
    Key for the hosting provider region.
    EOT
  nullable    = false
}

variable "region_short" {
  type        = string
  default     = ""
  description = <<-EOT
    Shortened version of the 'region'.
    Automatic shortening is done by removal of vowels unless handled by special
    cases such as 'us-east-1' => 'ue1', or 'us-west-2' => 'uw2'.
    EOT
  nullable    = true
}

variable "instance" {
  type        = string
  default     = ""
  description = <<-EOT
    Element to identify a tenant or copy of an environment (blue-green
    deployments). This is not used often.
    EOT
  nullable    = true
}

variable "instance_short" {
  type        = string
  default     = ""
  description = <<-EOT
    Shortened version of the 'instance'.
    Automatic shortening is done by removal of vowels.
    EOT
  nullable    = true
}

variable "project" {
  type        = string
  default     = ""
  description = <<-EOT
    Unique identifier for this project
    EOT
  nullable    = true
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional id elements that would be appended."
  nullable    = true
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to include."
  nullable    = true
}

variable "long_dns" {
  type        = bool
  default     = false
  description = "Use a dns_namespace that includes the namespace and role. The original dns_namespace was designed with namespace/role built-in to the DNS zone"
  nullable    = false
}

variable "context" {
  type = any
  default = {
    attributes     = []
    dns_namespace  = ""
    environment    = ""
    instance       = ""
    instance_short = ""
    namespace      = ""
    region         = ""
    region_short   = ""
    role           = ""
    role_short     = ""
    project        = ""
    tags           = {}
    long_dns       = false
  }
  description = "Allows the merging of an existing context with this one."
  nullable    = true
}
