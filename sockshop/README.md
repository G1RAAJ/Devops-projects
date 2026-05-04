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

-----------------------------------
Built-in-Node for Jenkins
------------------------------------
⚙️ PART 1 — Ensure 1GB Free Swap
1️⃣ Check
free -h

2️⃣ Create/resize swap to 2GB (recommended)
sudo swapoff -a
sudo rm -f /swapfile

sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

3️⃣ Make permanent
echo '/swapfile swap swap defaults 0 0' | sudo tee -a /etc/fstab

4️⃣ Verify
free -h

⚙️ PART 2 — Ensure 1GB Free Temp Space (/tmp)
1️⃣ Check
df -h /tmp

2️⃣ Quick cleanup
sudo rm -rf /tmp/*

3️⃣ Increase /tmp size to 2GB (permanent)
sudo nano /etc/fstab

Add:
tmpfs /tmp tmpfs defaults,size=2G 0 0

Apply:
sudo mount -o remount /tmp

4️⃣ Verify
df -h /tmp



