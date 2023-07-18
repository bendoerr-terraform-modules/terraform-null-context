output "shared" {
  value = {
    attributes             = local.gvn_attributes
    aws_account_name       = local.gvn_aws_account_name
    aws_account_name_short = local.aws_account_name_short
    aws_region             = local.gvn_aws_region
    aws_region_short       = local.aws_region_short
    dns_namespace          = local.dns_namespace
    environment            = local.environment
    instance               = local.gvn_instance
    instance_short         = local.instance_short
    namespace              = local.gvn_namespace
    tags                   = local.tags
  }
}

output "namespace" {
  value = local.gvn_namespace
}

output "environment" {
  value = local.environment
}

output "aws_account_name" {
  value = local.gvn_aws_account_name
}

output "aws_account_name_short" {
  value = local.aws_account_name_short
}

output "aws_region" {
  value = local.gvn_aws_region
}

output "aws_region_short" {
  value = local.aws_region_short
}

output "instance" {
  value = local.gvn_instance
}

output "instance_short" {
  value = local.instance_short
}

output "dns_namespace" {
  value = local.dns_namespace
}

output "attributes" {
  value = local.gvn_attributes
}

output "tags" {
  value = local.tags
}

