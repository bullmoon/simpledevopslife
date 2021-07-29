provider "aws" {
  region = "us-west-2"
}

data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "labProject" {}

output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "aws_region_name" {
  value = data.aws_region.current.name
}

output "aws_region_endpoint" {
  value = data.aws_region.current.endpoint
}

output "aws_region_description" {
  value = data.aws_region.current.description
}

output "labProject" {
  value = data.aws_vpcs.labProject.ids
}
