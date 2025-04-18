variable "cluster_name" {
  default = ""
}

variable "frontend_service_name" {
  default = ""
}

variable "max_frontend_capacity" {
  default = 2
}

variable "min_frontend_capacity" {
  default = 1
}

variable "scaling_adjustment" {
  default = 1
}

variable "cooldown_period" {
  default = 300
}

variable "target_utilization_percent" {
  default = 50
}
