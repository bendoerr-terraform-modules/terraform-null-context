module "ctx_no_env" {
  source         = "../.."
  namespace      = var.namespace
  role           = var.role
  role_short     = var.role_short
  region         = var.region
  region_short   = var.region_short
  instance       = var.instance
  instance_short = var.instance_short
  attributes     = var.attributes
  tags           = var.tags
}

output "ctx_no_env_shared" {
  value = module.ctx_no_env.shared
}