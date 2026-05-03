provider "aws" {
  region = "us-east-1"
}

#----------------------------
# EKS CLUSTER
#----------------------------

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.2"

  cluster_name    = "myeks-1"
  cluster_version = "1.30"

  vpc_id = "vpc-09a23ce107252dc4b"

  subnet_ids = [
    "subnet-04a75877b20cf9bf4",
    "subnet-079b66fb0be7efc65"
  ]

  #----------------------------
  # 🔥 NETWORK FIX (IMPORTANT)
  #----------------------------
  cluster_endpoint_public_access       = true
  cluster_endpoint_private_access      = false
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  #-----------------------------------
  # 🔥 FIX: avoid CloudWatch conflict
  #-----------------------------------
  create_cloudwatch_log_group = false

  #-----------------------------------
  # NODE GROUP
  #-----------------------------------
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
