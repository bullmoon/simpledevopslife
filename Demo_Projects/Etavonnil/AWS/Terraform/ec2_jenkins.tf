locals {
  instance_name     = "single-jenkins-instance"
  private_key_path  = "~/.ssh/jenkins_demo_ca_central_1.pem"
  ssh_user          = "ubuntu"
  key_name          = "jenkins_demo_ca_central_1"
}

# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
#
data "aws_ami" "latest_aws_ubuntu" {
  owners           = ["679593333241"]
  most_recent      = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "jenkins" {
  ami                         = data.aws_ami.latest_aws_ubuntu.id
  subnet_id                   = "subnet-8ad313d5"
  instance_type               = "t3.micro" # t2.micro is not available in that AZ
  associate_public_ip_address = true
  key_name                    = local.key_name
  monitoring                  = false
  security_groups             = [aws_security_group.jenkins.id]

  tags = {
    Name = "Jenkins"
  }

  lifecycle {
      prevent_destroy = true
  }

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]
    
    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = aws_instance.jenkins.public_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook  -i ${aws_instance.jenkins.public_dns}, --private-key ${local.private_key_path} ../Ansible/apps.yaml"
  }

}