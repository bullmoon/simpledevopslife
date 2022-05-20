# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
#
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "demo-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
  enable_dns_hostnames = true

  tags = {
    Terraform = "true"
    Environment = "demo"
  }
}