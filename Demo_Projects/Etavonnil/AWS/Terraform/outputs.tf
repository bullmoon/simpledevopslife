output "vpc_id" {
    value = module.vpc.vpc_id
}

output "private_subnets" {
    value = [module.vpc.private_subnets]
}

output "public_subnets" {
    value = [module.vpc.public_subnets]
}

output "vpc_security_group_ids" {
    value = [aws_security_group.allow_custom_ports.id]
}

output "jenkins_instance_ip" {
    value = aws_instance.jenkins.public_ip
}

output "jenkins_instance_fqdn" {
    value = aws_instance.jenkins.public_dns
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
data "aws_availability_zones" "working" {
  state = "available"
}

output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}