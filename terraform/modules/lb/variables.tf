variable "listener_port" {
  default = 80
}
variable "vpc_id" {}
variable "public_subnet_ids" {
  default = []
}
variable "lb_name" {
  default = "app-load-balancer"
}
variable "security_group_id" {}
variable "tg_frontend_port" {}
variable "front_health_port" {
  default = ""
}
