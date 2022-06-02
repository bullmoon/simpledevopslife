# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
#
resource "aws_security_group" "jenkins" {
  name        = "Dynamic Jenkins SG"
  description = "Allow SSH, HTTP, HTTPS, 8080 inbound traffic"
  # vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = ["22", "80", "443", "8080"]
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins_custom_ports"
  }
}