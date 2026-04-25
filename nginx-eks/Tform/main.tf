module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.2"

  cluster_name    = "myeks"
  cluster_version = "1.30"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  create_cloudwatch_log_group = false   # ✔ HERE

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.small"]
      desired_size   = 2
      min_size       = 1
      max_size       = 3
    }
  }
}
