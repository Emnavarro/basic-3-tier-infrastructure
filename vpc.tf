data "aws_availability_zones" "available" {
  state         = "available"
  exclude_names = ["us-east-1c"]
}

#Create VPC Terraform modules
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.16.0"
  #version = "~> 3.0"

  #VPC Basic Details
  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs             = var.vpc_availability_zones
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets


  #Database Subnets
  database_subnets                   = var.vpc_database_subnets
  create_database_subnet_group       = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table


  #NAT Gateway - Outbound Communication
  enable_nat_gateway = var.vpc_enable_nat_gateway #true
  single_nat_gateway = var.vpc_single_nat_gateway #true

  enable_dns_hostnames = true
  enable_dns_support   = true


  public_subnet_tags = {
    Name = "public-subnets"
  }
  private_subnet_tags = {
    Name = "private-subnets"
  }
  database_subnet_tags = {
    Name = "database-subnets"
  }
  tags = {
    Owner       = "Emanuel"
    Environment = "dev"
  }
}


