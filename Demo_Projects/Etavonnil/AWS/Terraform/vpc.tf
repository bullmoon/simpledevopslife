# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
#
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "demo-vpc"
  cidr = "10.0.0.0/16"

  #azs             = [data.aws_availability_zones.working.names]
  azs             = data.aws_availability_zones.working.names
  private_subnets = ["10.0.10.0/24", "10.0.20.0/24"]
  public_subnets  = ["10.0.30.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  enable_dns_hostnames = true

  tags = {
    Terraform = "true"
    Environment = "demo"
  }
}