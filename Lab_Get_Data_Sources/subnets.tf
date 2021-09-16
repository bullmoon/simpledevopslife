# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "private" {
  depends_on = [
    aws_vpc.VPC_for_lab,
  ]
  vpc_id = aws_vpc.VPC_for_lab.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "Private_Subnet"
  }
}

resource "aws_subnet" "public" {
  depends_on = [
    aws_vpc.VPC_for_lab,
  ]
vpc_id = aws_vpc.VPC_for_lab.id
  cidr_block = "10.0.10.0/24"
  tags = {
    Name = "Public_Subnet"
  }
}
