provider "aws" {
  region = "us-east-1"
}

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

  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = true

  create_cloudwatch_log_group = false
  create_kms_key              = false
  cluster_encryption_config   = []

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.small"]
      desired_size   = 2
      min_size       = 1
      max_size       = 3
    }
  }
}
