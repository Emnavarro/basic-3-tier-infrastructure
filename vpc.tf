data "aws_availability_zones" "available" {
  state = "available"
  exclude_names = [ "us-east-1c" ]
}

variable "vpc_availability_zones" {
  description = "VPC Availability Zones"
  type        = list(string)
  default     = ["us-east-1a","us-east-1b"]  
}

#Create VPC Terraform modules
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.16.0"
  #version = "~> 3.0"

  #VPC Basic Details
  name = "vpc-dev"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24","10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24","10.0.102.0/24"]

  #Database Subnets
  create_database_subnet_group = true 
  create_database_subnet_route_table = true
  database_subnets = ["10.0.151.0/24","10.0.152.0/24"]

  #NAT Gateway - Outbound Communication
  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support = true


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
    Owner = "Emanuel"
    Environment = "devss"
  }
}


