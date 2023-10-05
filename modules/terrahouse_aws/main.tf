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

// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
data "aws_caller_identity" "current" {}