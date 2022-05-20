# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
#
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  create = true
  name = "single-jenkins-instance"

  ami                    = "ami-0ca285d4c2cda3300"
  instance_type          = "t2.micro"
  key_name               = "jenkins_demo"
  monitoring             = false
  vpc_security_group_ids = [aws_security_group.allow_custom_ports.id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "demo"
  }
}