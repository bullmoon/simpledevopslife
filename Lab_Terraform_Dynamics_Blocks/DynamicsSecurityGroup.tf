resource "aws_security_group" "my_webserver" {
  name = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Dynamic SecurityGroup"
    Owner = "Scrooge McDuck"
  }
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-0b89310f457a9e90e"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Denis",
    l_name = "Astahov",
    names  = ["Vasya", "Kolya", "Petya", "John", "Donald", "Masha", "Lena", "Katya"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Denis Astahov"
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
}

output "my_instance_id" {
  description = "InstanceID of our WebSite"
  value       = aws_instance.my_webserver.id
}
