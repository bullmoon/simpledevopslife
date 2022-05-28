locals {
  cluster_name = "demo-eks"
}
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.20"
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "demo-grp-1"
      instance_type                 = var.instance_type
      additional_userdata           = ""
      asg_desired_capacity          = 1
    },
    {
      name                          = "demo-grp-2"
      instance_type                 = var.instance_type
      additional_userdata           = ""
      asg_desired_capacity          = 1
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
