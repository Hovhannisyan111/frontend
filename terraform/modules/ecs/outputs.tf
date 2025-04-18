output "frontend_task_arn" {
  value = aws_ecs_task_definition.frontend.arn
}

output "frontend_task_role_arn" {
  value = aws_iam_role.frontend_task_role.arn
}

output "frontend_container_name" {
  value = var.frontend_container_name
}
