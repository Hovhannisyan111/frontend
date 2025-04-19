# Load Balancer Module

This module creates an Application Load Balancer (ALB) in AWS, which distributes incoming traffic to the ECS tasks running the frontend application.

## Usage

```hcl
module "lb" {
  source  = "git::https://github.com/Hovhannisyan111/frontend.git//terraform/modules/lb?ref=main"
  lb_name = "Front-load-balancer"

  vpc_id            = data.terraform_remote_state.backend.outputs.vpc_id
  public_subnet_ids = data.terraform_remote_state.backend.outputs.public_subnet_ids
  tg_frontend_port  = 80
  security_group_id = module.sg.security_group_id
  front_health_port = 80
  listener_port     = 80
}

