#--- networking/variables.tf

variable "vpc_id" {}
variable "vpc_default_route_table_id" {}

variable "subnet_cidrs" {
  type = list(string)
}

variable "cluster-name" {
  default = "EKS-Sandbox"
  type    = string
}


# Common tags
variable "environment" {}
variable "repo_url" {}
variable "owner" {}
