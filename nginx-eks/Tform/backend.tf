# terraform {
#   backend "s3" {
#     bucket         = "myeks-terraform-state-bucket"
#     key            = "myeks/terraform.tfstate"
#     region         = "us-east-1"
#     #dynamodb_table = "myeks-lock-table"
#   }
# }
