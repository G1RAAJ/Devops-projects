provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "19.21.0"

  cluster_name    = "myeks-1"
  cluster_version = "1.30"

  vpc_id     = "vpc-09a23ce107252dc4b"
  subnet_ids = ["subnet-04a75877b20cf9bf4", "subnet-079b66fb0be7efc65"]

  enable_irsa = true

  eks_managed_node_groups = {
    default = {
      desired_size = 2
      max_size     = 2
      min_size     = 1
      instance_types = ["t2.medium"]
    }
  }
}

# 🔥 CRITICAL FIX (auto access)
resource "null_resource" "aws_auth" {
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = <<EOT
aws eks update-kubeconfig --region us-east-1 --name myeks-1
kubectl create configmap aws-auth -n kube-system --from-literal=mapRoles="$(cat <<EOF
- rolearn: arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/myeks-1-role
  username: jenkins
  groups:
    - system:masters
EOF
)" || true
EOT
  }
}
