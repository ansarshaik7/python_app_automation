module "ecr" {
  source = "terraform-aws-modules/ecr/aws"
  version = "3.2.0"

  repository_name = "python_app_repo"
  repository_image_tag_mutability = "MUTABLE"
  repository_encryption_type = "AES256"
  repository_image_scan_on_push = true
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
    Environment = "dev"
  }
}