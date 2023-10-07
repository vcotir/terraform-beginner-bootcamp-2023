terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  # cloud {
  #   organization = "Personal-7f53d9f15d9d"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
}

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

# module "terrahouse_aws" {
#   source = "./modules/terrahouse_aws"
#   user_uuid = var.user_uuid 
#   bucket_name = var.bucket_name
#   index_html_filepath = var.index_html_filepath
#   error_html_filepath = var.error_html_filepath
#   content_version = var.content_version
#   assets_path = var.assets_path
# }

resource "terratowns_home" "home" {
  name = "How to play Arcanum in 2023!!!"
  description = <<DESCRIPTION
Are you ready to embark on an enchanting journey through the steampunk world of Arcanum? As we step into the year 2023, it's the perfect time to dive into this timeless classic RPG. With its intricate storytelling, complex character interactions, and a world that seamlessly blends magic and technology, Arcanum offers an unforgettable gaming experience.
DESCRIPTION
  town = "gamers-grotto"
  content_version = 1
  domain_name = "2f3223f.cloudfront.net"
}
