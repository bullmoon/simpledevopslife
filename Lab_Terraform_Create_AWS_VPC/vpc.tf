### Configure the AWS Provider
provider "aws" {
     profile = "default"
     region = var.aws_region
 } 

### Create a VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "labvpc" {
     cidr_block = "10.0.0.0/16"
     tags = {
       Name = "lab_vpc"
     }
}

### Create subnets
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.labvpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "Public_Subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.labvpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "Private_Subnet"
  }
}

### Create Internet Gateway for VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "labigateway" {
  vpc_id = aws_vpc.labvpc.id
  tags = {
    Name = "Lab_Internet_GateWay"
  }
}

### Elastic IP for NAT Gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
resource "aws_eip" "lab_nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.labigateway]
  tags = {
    Name = "Lab_NAT_Gateway_EIP"
  }
}

### NAT Gateway for VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
resource "aws_nat_gateway" "labnat" {
  allocation_id = aws_eip.lab_nat_eip.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "Lab_NAT_Gateway"
  }
}

### Route Table for Public Subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.labvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.labigateway.id
  }
  tags = {
    Name = "Public_Route_Table"
  }
}

### Assoiation between Public Subnet and Public Route Table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

### Route Table for Private Subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.labvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.labnat.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

### Assoiation between Private Subnet and Private Route Table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

### Define security group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "labsecgroup" {
  name        = "http-https-allow"
  description = "Allow incoming HTTP and HTTPS and Connections"
  vpc_id      = "${aws_vpc.labvpc.id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "lab_vpc"
  }
}
