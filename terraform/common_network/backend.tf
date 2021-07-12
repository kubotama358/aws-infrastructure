terraform {
  backend "s3" {
    key    = "common_network.tfstate"
    region = "ap-northeast-1"
  }
}