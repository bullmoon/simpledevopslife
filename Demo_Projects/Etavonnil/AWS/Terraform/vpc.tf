# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
#
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "demo-vpc"
  cidr = "10.0.0.0/16"

<<<<<<< HEAD
  azs             = [data.aws_availability_zones.working.names[1]]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = false
=======
  azs             = ["us-west-2a"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
>>>>>>> d6eee2b4c29980c644de6e0d03337f8f1d085836
  enable_vpn_gateway = false
  enable_dns_hostnames = true

  tags = {
    Terraform = "true"
    Environment = "demo"
  }
}