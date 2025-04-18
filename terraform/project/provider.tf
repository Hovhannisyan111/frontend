provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "aws-terraformix"
    key    = "front/terraform.tfstate"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "backend" {
  backend = "s3"

  config = {
    bucket = "aws-terraformix"
    key    = "back/terraform.tfstate"
    region = "eu-central-1"
  }
}
