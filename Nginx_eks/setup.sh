#!/bin/bash

echo "🔹 Updating for Amazon Linux 2023"
sudo yum -y update

# Add the Jenkins repo
sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/rpm-stable/jenkins.repo

# Import a key file from Jenkins-CI to enable installation from the package
sudo rpm --import https://pkg.jenkins.io/rpm-stable/jenkins.io-2026.key
sudo yum -y upgrade

echo "🔹 Installing Java 21"
sudo yum -y install java-21-amazon-corretto

echo "🔹 Install, Enable, Start, Status of Jenkins"
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

echo "🔹 Installing AWS CLI"
sudo yum -y install awscli

echo "🔹 Installing Git"
sudo yum -y install git

echo "🔹 Installing Docker"
sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker

echo "🔹 Adding Jenkins user to Docker group"
sudo usermod -aG docker jenkins

echo "🔹 Installing kubectl"
curl -o kubectl https://amazon-eks.s3.us-east-1.amazonaws.com/latest/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "🔹 Installing eksctl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "🔹 Installing Terraform"
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install -y terraform

echo "🔹 Restarting Jenkins"
sudo systemctl restart jenkins

echo "🔹 Installed tools versions "
java -version
jenkins --version
aws --version
docker --version
kubectl version --client
eksctl version
terraform -version

echo "✅ Setup Completed Successfully"
