output "jenkins_instance_ip" {
    value = aws_instance.jenkins.public_ip
}

output "jenkins_instance_fqdn" {
    value = aws_instance.jenkins.public_dns
}
