Please read it below before Removing EKS
--------------
you can remove destroy stage by including on Jenkinsfile 
or 
remove by creating a new jenkins job (Destroy-eks) via build periodically (cron job)
⏰ Every 5 minutes (your case)
H/5 * * * *

⏰ Every 1 hour
H */1 * * *

Daily at 2 AM
H 2 * * *

👉 Note: 
if you can't remove all resource then remove manually like ec2 instances, eks, s3 bucket, roles, IAM user, load balancer, autoscalling group, elastic ips, security groups vpc and etc to avid bill.

Run on Jenkins EC2:
kubectl delete all --all || true

Delete Node Group
aws eks list-nodegroups --cluster-name eks

aws eks delete-nodegroup \
--cluster-name eks \
--nodegroup-name <nodegroup-name>

Wait until deleted
aws eks list-nodegroups --cluster-name eks

Delete EKS Cluster
aws eks delete-cluster \
--name eks \
--region us-east-1

⏳ Wait until gone
aws eks list-clusters

Delete VPC
aws ec2 describe-vpcs

Delete dependencies
# Delete NAT Gateway
aws ec2 describe-nat-gateways
aws ec2 delete-nat-gateway --nat-gateway-id <id>

# Release Elastic IP
aws ec2 release-address --allocation-id <id>

# Delete subnets
aws ec2 delete-subnet --subnet-id <id>

# Delete internet gateway
aws ec2 detach-internet-gateway --internet-gateway-id <id> --vpc-id <vpc-id>
aws ec2 delete-internet-gateway --internet-gateway-id <id>

aws ec2 delete-vpc --vpc-id <vpc-id>
