provider "aws" {
  region = "us-east-1"
}

########################################
# EKS CLUSTER
########################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.2"

  cluster_name    = "myeks-2"
  cluster_version = "1.30"

  vpc_id = "vpc-09a23ce107252dc4b"

  subnet_ids = [
    "subnet-04a75877b20cf9bf4",
    "subnet-079b66fb0be7efc65"
  ]

  ########################################
  # 🔥 NETWORK FIX (VERY IMPORTANT)
  ########################################
  cluster_endpoint_public_access       = true
  cluster_endpoint_private_access      = false
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  ########################################
  # NODE GROUP
  ########################################
  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.small"]

      desired_size = 2
      min_size     = 1
      max_size     = 3

      capacity_type = "ON_DEMAND"
    }
  }

  tags = {
    Project = "nginx-eks"
  }
}

########################################
# AWS AUTH (FIX FOR JENKINS ACCESS)
########################################

module "aws_auth" {
  source  = "terraform-aws-modules/eks/aws//modules/aws-auth"
  version = "20.37.2"

  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::652942059461:role/nginx-myeks-2-role"
      username = "jenkins"
      groups   = ["system:masters"]
    }
  ]
}
