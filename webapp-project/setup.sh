#!/bin/bash
set -e

# Amazon Linux 2023
# Update system
# --------------
sudo yum update -y

# Install Java
# -------------
sudo yum install java-21-amazon-corretto -y

# Install Jenkins
# ----------------
wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/rpm-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/rpm-stable/jenkins.io-2026.key

yum upgrade
yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins
systemctl status jenkins

# Install Docker
# ---------------
sudo yum install -y docker

systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user
usermod -aG docker jenkins


# Install Git
# -----------
sudo yum install -y git


# Install AWS CLI v2
# -------------------
yum install -y unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

# Install Terraform
# ------------------
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum install -y terraform

# Install kubectl
# ---------------
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/


# Install Helm
# -------------
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install eksctl
# ---------------
curl --silent --location \
"https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" \
| tar xz -C /tmp

mv /tmp/eksctl /usr/local/bin

# Restart Jenkins after Docker group change
# -----------------------------------------
systemctl restart jenkins


# Versions 
# ----------
java -version
jenkins --version
docker --version
git --version
aws --version
terraform -version
kubectl version --client
helm version
eksctl version