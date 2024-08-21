locals {
  # Merge
  gvn_attributes     = length(var.attributes) != 0 ? var.attributes : lookup(var.context, "attributes", [])
  gvn_role           = var.role != "" ? var.role : lookup(var.context, "role", "")
  gvn_role_short     = var.role_short != "" ? var.role_short : lookup(var.context, "role_short", "")
  gvn_region         = var.region != "" ? var.region : lookup(var.context, "region", "")
  gvn_region_short   = var.region_short != "" ? var.region_short : lookup(var.context, "region_short", "")
  gvn_environment    = var.environment != "" ? var.environment : lookup(var.context, "environment", "")
  gvn_instance       = var.instance != "" ? var.instance : lookup(var.context, "instance", "")
  gvn_instance_short = var.instance_short != "" ? var.instance_short : lookup(var.context, "instance_short", "")
  gvn_namespace      = var.namespace != "" ? var.namespace : lookup(var.context, "namespace", "")
  gvn_tags           = var.tags != {} ? var.tags : lookup(var.context, "tags", {})

  # Shorten names
  role_short_1   = local.gvn_role_short != "" ? local.gvn_role_short : replace(local.gvn_role, "/[aeiou]/", "")
  role_short_2   = local.gvn_role_short == "" && local.gvn_role == "production" ? "prod" : local.role_short_1
  role_short     = local.gvn_role_short == "" && local.gvn_role == "development" ? "dev" : local.role_short_2
  region_short   = local.gvn_region_short != "" ? local.gvn_region_short : replace(local.gvn_region, "/(\\b[a-z0-9])([^-]*)-?/", "$1")
  instance_short = local.gvn_instance_short != "" ? local.gvn_instance_short : replace(local.gvn_instance, "/[aeiou]/", "")

  # Build the environment value if not given
  environment = local.gvn_environment != "" ? local.gvn_environment : local.gvn_instance != "" ? format(
    # prd-ue1-mn
    "%s-%s-%s",
    local.role_short,
    local.region_short,
    local.instance_short,
    ) : format(
    # prd-ue1
    "%s-%s",
    local.role_short,
    local.region_short,
  )

  # Build a DNS fragment without the account name
  dns_namespace = local.gvn_instance != "" ? format(
    # main.ue1
    "%s.%s",
    local.instance_short,
    local.region_short,
    ) : format(
    # ue1
    "%s",
    local.region_short,
  )

  long_dns_namespace = local.gvn_instance != "" ? format(
    # main.ue1
    "%s.%s.%s.%s",
    local.instance_short,
    local.region_short,
    local.role_short,
    local.gvn_namespace
    ) : format(
    # ue1
    "%s.%s.%s",
    local.region_short,
    local.role_short,
    local.gvn_namespace
  )

  # Create tags
  role_tags           = { "Role" = local.gvn_role }
  region_tags         = { "Region" = local.gvn_region }
  instance_tags       = { "Instance" = local.gvn_instance }
  context_worksp_tags = { "Workspace" = terraform.workspace }
  project_tags        = { "Project" = var.project }
  tags = merge(
    local.gvn_tags,
    local.gvn_role != "" ? local.role_tags : {},
    local.gvn_region != "" ? local.region_tags : {},
    local.gvn_instance != "" ? local.instance_tags : {},
    var.project != "" ? local.project_tags : {},
    terraform.workspace != "" ? local.context_worksp_tags : {},
  )
}
