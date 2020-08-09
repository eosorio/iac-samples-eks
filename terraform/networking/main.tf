#--- networking/main.tf

data "aws_availability_zones" "available_azs" {}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id          = var.vpc_id

  tags   = {
    Name          = "EKS-Sandbox-igw"
    Environment   = var.environment
    IaCRepo       = var.repo_url
    Owner         = var.owner
  }
}

resource "aws_subnet" "eks_subnet" {
  count                   = length(var.subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available_azs.names[count.index]

  tags = {
    Name                                = "EKS-Sandbox-Subnet0${count.index+1}"
    Environment                         = var.environment
    IaCRepo                             = var.repo_url
    Owner                               = var.owner
    "kubernetes.io/cluster/EKS_Sandbox" = "shared"
  }
}

# Route tables

# resource "aws_default_route_table" "eks_default_rt" {
#   default_route_table_id  = var.vpc_default_route_table_id
#   id                      = "rtb-0f0aa00d2ce97b77f"
#   owner_id                = 
# }

# resource "aws_route_table" "eks_subnets_rt" {
#   vpc_id                  = var.vpc_id
# }