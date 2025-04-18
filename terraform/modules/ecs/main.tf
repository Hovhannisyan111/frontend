resource "aws_iam_role" "frontend_task_role" {
  name = var.task_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "frontend_task_policy" {
  name = var.task_policy_name
  role = aws_iam_role.frontend_task_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = ["s3:GetObject", "s3:PutObject"],
      Resource = "arn:aws:s3:::${var.bucket_name}/*"
    }]
  })
}

resource "aws_ecs_task_definition" "frontend" {
  family                   = "frontend-task"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = aws_iam_role.frontend_task_role.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name         = var.frontend_container_name
      image        = var.frontend_ecr_url
      cpu          = 256
      memory       = 512
      essential    = true
      portMappings = [{ containerPort = 80 }]
      #command      = ["sh", "-c", "aws s3 cp s3://${var.bucket_name}/index.html /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"]
      environment = [
        {
          name  = "S3_BUCKET_NAME",
          value = var.bucket_name
        },
        {
          name  = "AWS_REGION",
          value = var.aws_region
        }
      ]
    }
  ])
}
