Please read it below before Removing EKS
-----------------------------------------
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

