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
