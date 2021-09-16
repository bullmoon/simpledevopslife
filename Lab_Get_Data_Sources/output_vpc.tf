# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpcs
data "aws_vpcs" "labProject" {
  depends_on = [
    aws_vpc.VPC_for_lab,
  ]
  filter {
    name   = "tag:Name"
    values = ["LabVPC"]
  }
}

### A list of all the VPC Ids found.
output "labProject_ids" {
  value = data.aws_vpcs.labProject.ids
}

