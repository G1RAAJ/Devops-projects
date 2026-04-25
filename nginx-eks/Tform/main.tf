provider "aws" {
  region = "us-east-1"
}

############################
# VPC MODULE
############################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name = "eks-vpc"

  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Project = "nginx-eks"
  }
}

############################
# EKS MODULE
############################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.2"

  cluster_name    = "myeks"
  cluster_version = "1.30"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # 🔥 Fix repeated errors
  create_cloudwatch_log_group = false
  create_kms_key              = false

  enable_irsa = true

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

############################
# OUTPUTS
############################
output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
