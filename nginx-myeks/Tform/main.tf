terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Get current IAM identity
data "aws_caller_identity" "current" {}

# -------------------------------
# EKS CLUSTER
# -------------------------------
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = "myeks-1"
  cluster_version = "1.30"

  # 👉 UPDATE THESE WITH YOUR VALUES
  vpc_id     = "vpc-09a23ce107252dc4b"
  subnet_ids = [
    "subnet-04a75877b20cf9bf4",
    "subnet-079b66fb0be7efc65"
  ]

  enable_irsa = true

  # Managed Node Group
  eks_managed_node_groups = {
    default = {
      desired_size = 2
      min_size     = 1
      max_size     = 2

      instance_types = ["t3.medium"]
    }
  }
}

# -------------------------------
# KUBECONFIG SETUP
# -------------------------------
resource "null_resource" "kubeconfig" {
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region us-east-1 --name myeks-1"
  }
}

# -------------------------------
# aws-auth FIX (CRITICAL)
# -------------------------------
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      "myeks-1",
      "--region",
      "us-east-1"
    ]
  }
}

resource "kubernetes_config_map_v1" "aws_auth" {
  depends_on = [module.eks]

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/myeks-1-role"
        username = "jenkins"
        groups   = ["system:masters"]
      }
    ])
  }
}
