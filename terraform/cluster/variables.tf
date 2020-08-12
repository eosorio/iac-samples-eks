#--- cluster/variables.tf


variable "vpc_id" {}

variable "external_cidr" {
  type         = list(string)
  description  = "External CIDRs for reaching the cluster (for example a VPN CIDRs) or 0.0.0.0/0"
}

variable "subnet_id" {}

variable "cluster-name" {
  default = "EKS-Sandbox"
  type    = string
}
