provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::451442069649:role/access-power-user"
    session_name = "terraform_actions"
  }
}

terraform {
  backend "s3" {
    encrypt        = true
    region         = "us-east-1"
    role_arn       = "arn:aws:iam::451442069649:role/access-power-user"
    bucket         = "terraform-state-sk-2023"
    key            = "tf-testing.tfstate"
    dynamodb_table = "tf-lock-testing"
  }
}

resource "aws_dynamodb_table" "terraform_statelock_testing" {
  name           = "tf-lock-testing"
  read_capacity  = 20
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-sk-2023"

  tags = {
    Name        = "terraform-state-sk-2023"
    Environment = "testing"
  }
}

module "networking" {
  source = "../../modules/network"

  cidr        = "10.0.0.0/16"
  environment = "testing"
  region      = "us-east-1"
}

module "ecr" {
  source = "../../modules/ecr"

  app_repositiry_name               = "time-app"
  chart_repository_name             = "python-time-app-charts"
  repository_read_write_access_arns = "arn:aws:iam::451442069649:role/access-power-user"
  environment                       = "testing"

}

module "eks" {
  source = "../../modules/eks"

  environment  = "testing"
  cluster_name = "small-test-cluster"

  vpc_id          = module.networking.vpc_id
  intra_subnets   = module.networking.intra_subnets
  private_subnets = module.networking.private_subnets
  public_subnets  = module.networking.public_subnets
}

module "helm" {
  source = "../../modules/helm"

  environment = "testing"

  vpc_id                             = module.networking.vpc_id
  cluster_name                       = module.eks.cluster_name
  cluster_endpoint                   = module.eks.cluster_endpoint
  cluster_certificate_authority_data = module.eks.cluster_certificate_authority_data
  oidc_provider_arn                  = module.eks.oidc_provider_arn

  app_repositiry_name               = module.ecr.app_repositiry_name
  chart_repository_name             = module.ecr.chart_repository_name
  repository_read_write_access_arns = module.ecr.repository_read_write_access_arns
}
