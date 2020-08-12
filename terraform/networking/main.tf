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
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available_azs.names[count.index]

  tags = {
    Name                                        = "EKS-Sandbox-Subnet0${count.index+1}"
    Environment                                 = var.environment
    IaCRepo                                     = var.repo_url
    Owner                                       = var.owner
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  }
}

# Route tables

# resource "aws_default_route_table" "eks_default_rt" {
#   default_route_table_id     = var.vpc_default_route_table_id

#   tags = {
#     Name                                = "EKS-Sandbox-default"
#     Environment                         = var.environment
#     IaCRepo                             = var.repo_url
#     Owner                               = var.owner
#   }
# }

resource "aws_route_table" "eks_subnets_rt" {
  vpc_id                  = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }
}

resource "aws_route_table_association" "eks_rt_assoc" {
  count          = length(var.subnet_cidrs)

  subnet_id      = aws_subnet.eks_subnet.*.id[count.index]
  route_table_id = aws_route_table.eks_subnets_rt.id
}