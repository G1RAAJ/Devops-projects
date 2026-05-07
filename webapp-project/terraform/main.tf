terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "20.0.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  enable_irsa = true

  eks_managed_node_groups = {

    default = {

      desired_size = 2
      max_size     = 3
      min_size     = 1

      instance_types = ["t3.small"]

      ami_type = "AL2_x86_64"
    }
  }

  tags = {
    Project = "webapp-project"
  }
}
