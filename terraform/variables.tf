#--- root variables.tf

# Common tags
variable "environment" {}
variable "repo_url" {}
variable "service" {}
variable "owner" {}

# AWS environment
variable "aws_profile" {}
variable "aws_shared_credentials_file" {}
variable "aws_region" {}

variable "cluster-name" {
  default = "EKS-Sandbox"
  type    = string
}

variable "asg_capacity" {
  default = 1
  type    = number
}

variable "asg_min_size" {
  default = 1
  type    = number
}

variable "asg_max_size" {
  default = 1
  type    = number
}


# VPC
variable "vpc_cidr" {}
variable "vpc_id" {}
variable "vpc_default_route_table_id" {}

# Networking
variable "subnet_cidrs" {
  type = list(string)
}
variable "subnet_id" {
  type = list(string)
}

# Cluster module
variable "external-cidr" {
  type         = list(string)
  description  = "External CIDRs for reaching the cluster (for example a VPN CIDRs) or 0.0.0.0/0"
}

