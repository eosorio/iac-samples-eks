#--- root main.tf

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_vpc" "eks_vpc" {
    cidr_block            = var.vpc_cidr
    enable_dns_hostnames  = true
    enable_dns_support    = true

    tags = {
        Name          = "EKS-Sandbox-VPC"
        Environment   = module.tags.environment
        IaCRepo       = module.tags.repo_url
    }
}

module "tags" {
  source              = "./tags"

  repo_url            = var.repo_url
  environment         = var.environment
  service             = var.service
  owner               = var.owner
}

module "networking" {
  source            = "./networking"

  environment                  = module.tags.environment
  repo_url                     = module.tags.repo_url
  owner                        = module.tags.owner

  vpc_id                       = aws_vpc.eks_vpc.id
  vpc_default_route_table_id   = aws_vpc.eks_vpc.default_route_table_id
  subnet_cidrs                 = var.subnet_cidrs
}

module "cluster" {
  source          = "./cluster"

  vpc_id          = aws_vpc.eks_vpc.id
}
