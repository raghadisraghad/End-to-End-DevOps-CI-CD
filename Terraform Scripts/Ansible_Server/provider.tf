terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0" # Optional but recommended in production
    }
  }

  backend "s3" {
    bucket         = "projectbucketest"
    key            = "ansible/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    region         = "eu-north-1"
  }
}

provider "aws" {
  region = "eu-north-1"
}