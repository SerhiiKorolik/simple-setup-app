module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "${var.environment}-vpc"

  azs = local.azs

  private_subnets = [for k, v in local.azs : cidrsubnet(var.cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.cidr, 8, k + 48)]
  intra_subnets   = [for k, v in local.azs : cidrsubnet(var.cidr, 8, k + 52)]

  cidr = var.cidr

  create_igw              = true
  enable_nat_gateway      = true
  single_nat_gateway      = true
  create_egress_only_igw  = true
  map_public_ip_on_launch = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
