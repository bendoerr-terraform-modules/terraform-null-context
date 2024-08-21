module "ctx_full_long_dns" {
  source         = "../.."
  namespace      = var.namespace
  environment    = var.environment
  role           = var.role
  role_short     = var.role_short
  region         = var.region
  region_short   = var.region_short
  instance       = var.instance
  instance_short = var.instance_short
  project        = var.project
  attributes     = var.attributes
  tags           = var.tags
  long_dns       = true
}

output "ctx_full_long_dns_shared" {
  value = module.ctx_full_long_dns.shared
}
