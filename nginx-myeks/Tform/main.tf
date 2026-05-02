terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

# -------------------------------
# EKS CLUSTER
# -------------------------------
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = "myeks-1"
  cluster_version = "1.29"

  vpc_id     = "vpc-REPLACE"             # 🔴 change
  subnet_ids = ["subnet-AAA", "subnet-BBB"]  # 🔴 change (2 subnets, different AZ)

  # 🔥 IMPORTANT (fix your previous network issue)
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  enable_irsa = true

  # 🔥 Node group (free-tier safe)
  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      min_size       = 1
      max_size       = 2
      instance_types = ["t2.micro"]
    }
  }

  # 🔥 THIS FIXES YOUR AUTH ISSUE (NO kubernetes provider needed)
  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/myeks-1-role"
      username = "jenkins"
      groups   = ["system:masters"]
    }
  ]
}
