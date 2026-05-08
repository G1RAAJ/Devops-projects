Project: Github-Jenkins-Terraform--EKS-Docker-ECR
webapp-project/
├── app/
│   ├── Dockerfile
│   ├── package.json
│   ├── server.js
│   └── public/
│       └── index.html
│
├── helm/
│   └── webapp/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
│           ├── deployment.yaml
│           └── service.yaml
│
├── jenkins/
│   └── Jenkinsfile
│
├── scripts/
│   ├── build.sh
│   └── deploy.sh
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   └── outputs.tf
│
├── kubernetes/
│   ├── deployment.yaml
│   └── service.yaml
│
├── README.md
└── setup.sh


