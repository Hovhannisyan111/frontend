variable "task_policy_name" {
  default = "front_task_policy"
}

variable "task_role_name" {
  default = "FrontendTaskRole"
}

variable "frontend_ecr_url" {}

variable "bucket_name" {
  default = ""
}

variable "aws_region" {
  default = "eu-central-1"
}

variable "frontend_container_name" {
  default = "front-container"
}

variable "execution_role_arn" {
  default = ""
}

