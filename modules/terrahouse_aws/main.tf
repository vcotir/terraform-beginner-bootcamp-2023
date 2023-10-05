terraform {
  # cloud {
  #   organization = "Personal-7f53d9f15d9d"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

resource "aws_s3_bucket" "website_bucket" {
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  bucket = var.bucket_name
  tags = {
    UserUuid = var.user_uuid
  }
}
