resource "aws_ecs_service" "frontend" {
  name            = var.frontend_service_name
  cluster         = var.ecs_cluster_id
  task_definition = var.frontend_task
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = [var.public_subnet_ids[0]]
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.frontend_tg_arn
    container_name   = var.frontend_container_name
    container_port   = var.frontend_container_port
  }
}
