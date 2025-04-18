variable "ecs_cluster_id" {}
variable "frontend_task" {}
variable "security_group_id" {}
variable "public_subnet_ids" {
  default = []
}
variable "frontend_tg_arn" {
  default = ""
}

variable "frontend_container_name" {
  default = "frontend-container"
}

variable "frontend_service_name" {
  default = "frontend-service"
}

variable "frontend_container_port" {
  default = 80
}
