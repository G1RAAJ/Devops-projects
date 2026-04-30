module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.2"

  cluster_name    = "myeks-2"
  cluster_version = "1.30"

  vpc_id     = "vpc-09a23ce107252dc4b"
  subnet_ids = ["subnet-04a75877b20cf9bf4", "subnet-079b66fb0be7efc65"]

  # ✅ ADD HERE 👇
  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::652942059461:role/nginx-myeks-2-role"
      username = "jenkins"
      groups   = ["system:masters"]
    }
  ]

  # networking fix (important)
  cluster_endpoint_public_access       = true
  cluster_endpoint_private_access      = false
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.small"]
      desired_size   = 2
      min_size       = 1
      max_size       = 3
    }
  }
}
