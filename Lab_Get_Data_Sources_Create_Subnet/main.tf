data "aws_availability_zones" "working" {}
data "aws_region" "current" {}
data "aws_vpc" "Default" {
  tags = {
    Name = "default"
  }
}
data "aws_caller_identity" "current" {}


output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names[0]
}

output "aws_region_name" {
  value = data.aws_region.current.name
}

output "aws_region_description" {
  value = data.aws_region.current.description
}

output "aws_vpc_default_ID" {
  value = data.aws_vpc.Default.id
}

output "caller_user" {
  value = data.aws_caller_identity.current.account_id
}

# Create subnet in default VPC

resource "aws_subnet" "subnet_lab_1" {
  vpc_id            = data.aws_vpc.Default.id
  availability_zone = data.aws_availability_zones.working.names[0]
  cidr_block        = "172.31.0.0/24"
  tags = {
    Name    = "SubnetLab1 in ${data.aws_availability_zones.working.names[0]}"
    Account = data.aws_caller_identity.current.user_id
  }

}
