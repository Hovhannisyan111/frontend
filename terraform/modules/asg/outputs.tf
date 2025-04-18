output "frontend_scaling_target" {
  value = aws_appautoscaling_target.frontend_scale.id
}

output "frontend_scaling_policy_name" {
  value = aws_appautoscaling_policy.frontend_tracking.name
}
