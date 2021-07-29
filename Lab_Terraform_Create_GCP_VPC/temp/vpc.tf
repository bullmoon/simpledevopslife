resource “aws_vpc” “lab-vpc” {
    cidr_block = “10.0.0.0/16”
    enable_dns_support = “true” #gives you an internal domain name
    enable_dns_hostnames = “true” #gives you an internal host name
    enable_classiclink = “false”
    instance_tenancy = “default”    
    
    tags {
        Name = “lab-vpc”
    }
}

resource “aws_subnet” “lab-subnet-public-1” {
    vpc_id = “${aws_vpc.lab-vpc.id}”
    cidr_block = “10.0.1.0/24”
    map_public_ip_on_launch = “true” //it makes this a public subnet
    availability_zone = “us-west-2a”
    tags {
        Name = “lab-subnet-public-1”
    }
}
