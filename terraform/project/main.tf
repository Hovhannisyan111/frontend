module "sg" {
  source      = "../modules/sg"
  sg_name     = "Frontend-Security"
  vpc_id      = data.terraform_remote_state.backend.outputs.vpc_id
  allow_ports = [80, 443]
}

module "s3" {
  source      = "../modules/bucket"
  bucket_name = "frontend-created-bucket-789"
  #index_key   = "index.html"
  #index_path  = "./index.html"
}

module "ecr" {
  source        = "../modules/ecr"
  ecr_repo_name = "frontend"
  frontend_path = "../../docker"
}

module "lb" {
  source  = "../modules/lb"
  lb_name = "Front-load-balancer"

  vpc_id            = data.terraform_remote_state.backend.outputs.vpc_id
  public_subnet_ids = data.terraform_remote_state.backend.outputs.public_subnet_ids
  tg_frontend_port  = 80
  security_group_id = module.sg.security_group_id
  front_health_port = 80
  listener_port     = 80
}

module "ecs" {
  source                  = "../modules/ecs"
  frontend_container_name = "Frontend-container"
  frontend_ecr_url        = module.ecr.frontend_ecr_url
  bucket_name             = module.s3.bucket_name
  task_policy_name        = "frontend-task-policy"
  task_role_name          = "FrontendTaskRole"
  execution_role_arn      = data.terraform_remote_state.backend.outputs.execution_role_arn
}

module "service" {
  source                  = "../modules/service"
  frontend_service_name   = "Frontend"
  frontend_container_name = module.ecs.frontend_container_name
  ecs_cluster_id          = data.terraform_remote_state.backend.outputs.ecs_cluster_id
  frontend_task           = module.ecs.frontend_task_arn
  public_subnet_ids       = data.terraform_remote_state.backend.outputs.public_subnet_ids
  security_group_id       = module.sg.security_group_id
  frontend_tg_arn         = module.lb.frontend_tg_arn
  frontend_container_port = 80
}

module "asg" {
  source                = "../modules/asg"
  cluster_name          = data.terraform_remote_state.backend.outputs.cluster_name #"ECS-cluster"
  frontend_service_name = module.service.frontend_service_name
  max_frontend_capacity = 2
  min_frontend_capacity = 1
  scaling_adjustment    = 1
  cooldown_period       = 300
}
