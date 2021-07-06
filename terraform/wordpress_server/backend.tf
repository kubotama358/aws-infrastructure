terraform {
  backend "s3" {
    key    = "wordpress_server.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "remote_state_common_network" {
  backend = "s3"
  config = {
    bucket  = "aws-infra-tfstate"
    key     = "env:/${var.profile_name}/common_network.tfstate"
    region  = "ap-northeast-1"
    profile = var.profile_name
  }
}