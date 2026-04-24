variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "myeks"
}

variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}

