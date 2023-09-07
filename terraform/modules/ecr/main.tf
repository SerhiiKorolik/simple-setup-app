module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = var.app_repositiry_name

  repository_read_write_access_arns = [var.repository_read_write_access_arns]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "chart_ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = var.chart_repository_name

  repository_read_write_access_arns = [var.repository_read_write_access_arns]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
