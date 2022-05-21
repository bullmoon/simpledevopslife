# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
#
data "aws_ami" "latest_aws_linux" {
  owners           = ["amazon"]
  most_recent      = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  create = true
  name = "single-jenkins-instance"

  ami                    = data.aws_ami.latest_aws_linux.id
  monitoring             = false
  vpc_security_group_ids = [aws_security_group.allow_custom_ports.id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "demo"
  }
}