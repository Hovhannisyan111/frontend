resource "aws_appautoscaling_target" "frontend_scale" {
  max_capacity       = var.max_frontend_capacity
  min_capacity       = var.min_frontend_capacity
  resource_id        = "service/${var.cluster_name}/${var.frontend_service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "frontend_tracking" {
  name               = "frontend-tracking-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.frontend_scale.resource_id
  scalable_dimension = aws_appautoscaling_target.frontend_scale.scalable_dimension
  service_namespace  = aws_appautoscaling_target.frontend_scale.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = var.target_utilization_percent
    scale_in_cooldown  = var.cooldown_period
    scale_out_cooldown = var.cooldown_period
  }
}
