# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
#
<<<<<<< HEAD
data "aws_ami" "latest_aws_linux" {
  owners           = ["amazon"]
  most_recent      = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}
=======
>>>>>>> d6eee2b4c29980c644de6e0d03337f8f1d085836
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  create = true
  name = "single-jenkins-instance"

<<<<<<< HEAD
  ami                    = data.aws_ami.latest_aws_linux.id
=======
  ami                    = "ami-0ca285d4c2cda3300"
  instance_type          = "t2.micro"
  key_name               = "jenkins_demo"
>>>>>>> d6eee2b4c29980c644de6e0d03337f8f1d085836
  monitoring             = false
  vpc_security_group_ids = [aws_security_group.allow_custom_ports.id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "demo"
  }
}