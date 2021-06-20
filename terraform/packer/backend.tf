terraform {
  backend "s3" {
    key    = "packer.tfstate"
    region = "ap-northeast-1"
  }
}

