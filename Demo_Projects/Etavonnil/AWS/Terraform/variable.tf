variable "AWS_REGION" {
    description = "Region of AWS VPC"
    type = string
    default = "ca-central-1"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "key_name" {
    description = "ssh key pair for current region"
    type = string
}