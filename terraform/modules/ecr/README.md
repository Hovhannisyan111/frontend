# ECR Module

This module creates an Amazon ECR repository to store the Docker images for the frontend application.

## Usage

```hcl
module "ecr" {
  source        = "git::https://github.com/Hovhannisyan111/frontend.git//terraform/modules/ecr?ref=main"
  ecr_repo_name = "frontend"
  frontend_path = "../../docker"
}
