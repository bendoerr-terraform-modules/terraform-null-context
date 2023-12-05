module "ctx_short" {
  source     = "../.."
  namespace  = var.namespace
  role       = var.role
  region     = var.region
  attributes = var.attributes
  tags       = var.tags
}

output "ctx_short_shared" {
  value = module.ctx_short.shared
}
