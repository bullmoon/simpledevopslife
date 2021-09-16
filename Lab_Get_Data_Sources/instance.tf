# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "node" {
  depends_on = [
    aws_vpc.VPC_for_lab,
  ]
  ami            = "ami-005e54dee72cc1d00" # us-west-2
  instance_type  = "t2.micro"
  subnet_id      = aws_subnet.private.id
  tags = {
    Name = "Node001"
  }
}
