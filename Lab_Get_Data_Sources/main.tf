provider "aws" {
  profile = "default"
  region = var.aws_region
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
data "aws_availability_zones" "working" {
  state = "available"
}

output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region
data "aws_region" "current" {}

output "aws_region_name" {
  value  = data.aws_region.current.name
}
output "aws_region_endpoint" {
  value  = data.aws_region.current.endpoint
}
output "aws_region_description" {
  value = data.aws_region.current.description
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}
output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}
