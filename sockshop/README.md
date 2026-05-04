sockshop/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
│
├── jenkins/
│   └── Jenkinsfile
│
├── docker/
│   └── frontend/
│       └── Dockerfile
│
├── helm/
│   └── sockshop/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
│           ├── deployment.yaml
│           └── service.yam
│
├── scripts/
│   ├── build.sh
│   └── deploy.sh
│
└── README.md


# Sock Shop DevOps Project
## Tools Used
- AWS EKS
- Terraform
- Jenkins
- Docker
- Helm

## Steps

1. Provision EKS:
   terraform init
   terraform apply

2. Configure kubectl:
   aws eks update-kubeconfig --region us-east-1 --name sockshop-cluster

3. Run Jenkins pipeline

4. Access app:
   kubectl get svc frontend


