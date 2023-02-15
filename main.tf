# -----------------------------------------------
# VPC for VPC-ECS
# -----------------------------------------------
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.19.0"

  name = "${var.project_name}-vpc"
  cidr = var.vpc_cidr

  azs             = ["${var.region}a", "${var.region}b"]
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway      = true
  single_nat_gateway      = true
  enable_dns_hostnames    = true
  map_public_ip_on_launch = false

  tags = var.tags
}
# -----------------------------------------------
# VPC-ENDPOINMTS for VPC-ECS
# -----------------------------------------------
module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 3.19.0"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [module.vpc_endpoints_security_group.security_group_id]
  tags               = var.tags

  endpoints = {
    s3 = {
      service    = "s3"
      subnet_ids = module.vpc.private_subnets
      tags       = var.tags
    },
    ecr_api = {
      service             = "ecr.api"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = var.tags
    },
    ecr_dkr = {
      service             = "ecr.dkr"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = var.tags
    },
    logs = {
      service             = "logs"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = var.tags
    }
  }
}
# -----------------------------------------------
# ENDPOINTS_SG for VPC-ECS
# -----------------------------------------------
module "vpc_endpoints_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.17.0"

  vpc_id              = module.vpc.vpc_id
  name                = "${var.project_name}-vpc-endpoints"
  tags                = var.tags
  ingress_cidr_blocks = [var.vpc_cidr]
  ingress_rules       = ["https-443-tcp"]
}
