output "namespace" {
  value = local.gvn_namespace
  description = "The evaluated namespace"
}

output "environment" {
  value = local.environment
  description = "The evaluated environment"
}

output "role" {
  value = local.gvn_role
  description = "The evaluated role"
}

output "role_short" {
  value = local.role_short
  description = "The evaluated role"
}

output "region" {
  value = local.gvn_region
  description = "The evaluated region"
}

output "region_short" {
  value = local.region_short
  description = "The evaluated region"
}

output "instance" {
  value = local.gvn_instance
  description = "The evaluated instance"
}

output "instance_short" {
  value = local.instance_short
  description = "The evaluated instance"
}

output "dns_namespace" {
  value = local.dns_namespace
  description = "A DNS namespace"
}

output "attributes" {
  value = local.gvn_attributes
  description = "The evaluated attributes"
}

output "tags" {
  value = local.tags
  description = "The evaluated tags"
}

output "shared" {
  value = {
    attributes     = local.gvn_attributes
    role           = local.gvn_role
    role_short     = local.role_short
    region         = local.gvn_region
    region_short   = local.region_short
    dns_namespace  = local.dns_namespace
    environment    = local.environment
    instance       = local.gvn_instance
    instance_short = local.instance_short
    namespace      = local.gvn_namespace
    tags           = local.tags
  }
  description = "Used for sharing the context with other modules"
}
