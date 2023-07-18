################################################################################
# Input Variables
################################################################################

variable "context" {
  # TODO: When the following issue is fixed, replace with type = map(any)
  # https://github.com/hashicorp/terraform/issues/21588
  type = object({
    attributes             = list(string)
    aws_account_name       = string
    aws_account_name_short = string
    aws_region             = string
    aws_region_short       = string
    dns_namespace          = string
    environment            = string
    instance               = string
    instance_short         = string
    namespace              = string
    tags                   = map(string)
  })
  default = {
    attributes             = []
    aws_account_name       = ""
    aws_account_name_short = ""
    aws_region             = ""
    aws_region_short       = ""
    dns_namespace          = ""
    environment            = ""
    instance               = ""
    instance_short         = ""
    namespace              = ""
    tags                   = {}
  }
}

variable "environment" {
  type    = string
  default = ""
}

variable "namespace" {
  type    = string
  default = ""
}

variable "aws_account_name" {
  type    = string
  default = ""
}

variable "aws_account_name_short" {
  type    = string
  default = ""
}

variable "aws_region" {
  type    = string
  default = ""
}

variable "aws_region_short" {
  type    = string
  default = ""
}

variable "instance" {
  type    = string
  default = ""
}

variable "instance_short" {
  type    = string
  default = ""
}

variable "attributes" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
