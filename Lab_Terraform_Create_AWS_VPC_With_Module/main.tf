provider "aws" {
  region = "us-west-2"
}

# Create AWS VPC using module AWS
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"
  # insert the 18 required variables here

  name = "main"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.0.0/24"]

  enable_nat_gateway = true

  tags = {
    Environment = "staging"
  }
}

