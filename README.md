# iac-samples-eks
Infrastructure-As-Code samples: Amazon EKS

Sample Terraform plan:
terraform plan -var-file=awsprofile.tfvars -var='external-cidr=["192.168.0.0/16"]'

Where external-cidr is the CIDR which will have access from an external network to the cluster. In the above example it is assumed that the VPN CIDR for reaching the cluster is 192.168.0.0/16

