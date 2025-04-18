data "aws_caller_identity" "current" {}

resource "aws_ecr_repository" "frontend" {
  name         = var.ecr_repo_name
  force_delete = true
}

resource "aws_ecr_lifecycle_policy" "frontend_policy" {
  repository = aws_ecr_repository.frontend.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Delete untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 1
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "null_resource" "push_frontend" {
  provisioner "local-exec" {
    command = <<EOT
    docker build -t my-frontend-app:latest ${var.frontend_path}
    aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com
      docker tag my-frontend-app:latest ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/frontend:latest
      docker push ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/frontend:latest
    EOT
  }

  depends_on = [aws_ecr_repository.frontend]
}
