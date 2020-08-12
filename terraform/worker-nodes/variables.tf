#--- worker-nodes/variables.tf

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

variable "subnet_id" {
  type    = list(string)
}

variable "cluster-name" {
  default = "EKS-Sandbox"
  type    = string
}
