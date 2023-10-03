terraform {
  cloud {
    organization = "Personal-7f53d9f15d9d"

    workspaces {
      name = "terra-house-1"
    }
  }
  
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }

    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs
resource "random_string" "bucket_name" {
  lower = true 
  upper = false
  length = 63
  special = false
}

resource "aws_s3_bucket" "example" {
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  bucket = random_string.bucket_name.result
}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}

