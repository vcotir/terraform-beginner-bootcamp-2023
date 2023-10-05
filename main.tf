terraform {
  # cloud {
  #   organization = "Personal-7f53d9f15d9d"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid 
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
}
