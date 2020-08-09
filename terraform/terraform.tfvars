#--- root terraform.tfvars
# Common tags
environment                = "Devel"
#repo_url                   = "https://github.com/eosorio/iac-samples-eks/terraform"
repo_url                   = ""
service                    = "eks-sample"
#owner                      = ""

vpc_cidr                   = "192.168.0.0/16"
vpc_id                     = ""
vpc_default_route_table_id = ""

# Networking
subnet_cidrs       = [
  "192.168.64.0/18",
  "192.168.128.0/18",
  "192.168.192.0/18"
]

subnet_id          = [
  "",
  "",
  ""
]

security_group_ssh_id      = ""

