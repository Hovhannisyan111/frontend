variable "sg_name" {
  default = "Frontend Security Group"
}

variable "vpc_id" {
  default = ""
}

variable "allow_ports" {
  default = [80, 443]
}

variable "cidr_blocks" {
  default = ["0.0.0.0/0"]
}
