terraform {
  required_version = "~> 1.12.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.83.0"
    }
  }
  backend "s3" {
    bucket  = "booklyn-tfstate"
    region  = "ap-northeast-1"
    profile = "default"
    key     = "production.tfstate"
    encrypt = true
  }
}
