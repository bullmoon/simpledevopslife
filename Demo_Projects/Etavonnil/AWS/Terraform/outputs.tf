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
    value = module.ec2_instance.public_ip
}

output "jenkins_instance_fqdn" {
    value = module.ec2_instance.public_dns
}