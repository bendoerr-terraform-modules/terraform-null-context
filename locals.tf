locals {
  // Merge `shared` input vs individual. This allows a shared context to be
  // passed arround and re-contextified as needed.
  gvn_attributes             = var.attributes != [] ? var.attributes : lookup(var.context, "attributes", [])
  gvn_aws_account_name       = var.aws_account_name != "" ? var.aws_account_name : lookup(var.context, "aws_account_name", "")
  gvn_aws_account_name_short = var.aws_account_name_short != "" ? var.aws_account_name_short : lookup(var.context, "aws_account_name_short", "")
  gvn_aws_region             = var.aws_region != "" ? var.aws_region : lookup(var.context, "aws_region", "")
  gvn_aws_region_short       = var.aws_region_short != "" ? var.aws_region_short : lookup(var.context, "aws_region_short", "")
  gvn_environment            = var.environment != "" ? var.environment : lookup(var.context, "environment", "")
  gvn_instance               = var.instance != "" ? var.instance : lookup(var.context, "instance", "")
  gvn_instance_short         = var.instance_short != "" ? var.instance_short : lookup(var.context, "instance_short", "")
  gvn_namespace              = var.namespace != "" ? var.namespace : lookup(var.context, "namespace", "bdrk")
  gvn_tags                   = var.tags != {} ? var.tags : lookup(var.context, "tags", {})

  // Shorten names if an explicit is not given
  aws_account_name_short = local.gvn_aws_account_name_short != "" ? local.gvn_aws_account_name_short : replace(local.gvn_aws_account_name, "/[aeiou]/", "")
  aws_region_short       = local.gvn_aws_region_short != "" ? local.gvn_aws_region_short : replace(local.gvn_aws_region, "/(\\b[a-z0-9])([^-]*\\b)-?/g", "$1")
  instance_short         = local.gvn_instance_short != "" ? local.gvn_instance_short : replace(local.gvn_instance, "/[aeiou]/", "")

  // Build the environment
  environment = local.gvn_environment != "" ? local.gvn_environment : local.gvn_instance != "" ? format(
    // prd-ue1-mn
    "%s-%s-%s",
    local.aws_account_name_short,
    local.aws_region_short,
    local.instance_short,
    ) : format(
    // prd-ue1
    "%s-%s",
    local.aws_account_name_short,
    local.aws_region_short,
  )

  // Build a DNS fragment without the account name
  dns_namespace = local.gvn_instance != "" ? format(
    // main.ue1
    "%s.%s",
    local.instance_short,
    local.aws_region_short,
    ) : format(
    // ue1
    "%s",
    local.aws_region_short,
  )

  // Create tags
  account_tags        = { "Account" = local.gvn_aws_account_name }
  region_tags         = { "Region" = local.gvn_aws_region }
  instance_tags       = { "Instance" = local.gvn_instance }
  context_worksp_tags = { "Workspace" = terraform.workspace }
  tags = merge(
    local.gvn_tags,
    local.gvn_aws_account_name != "" ? local.account_tags : {},
    local.gvn_aws_region != "" ? local.region_tags : {},
    local.gvn_instance != "" ? local.instance_tags : {},
    terraform.workspace != "" ? local.context_worksp_tags : {},
  )
}
