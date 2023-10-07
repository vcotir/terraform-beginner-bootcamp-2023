terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
   organization = "Personal-7f53d9f15d9d"
   workspaces {
     name = "terra-house-1"
   }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_arcanum_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.arcanum.public_path
  content_version = var.arcanum.content_version
}

resource "terratowns_home" "home_arcanum" {
  name = "How to play Runescape in 2023!"
  description = <<DESCRIPTION
Are you ready to embark on an epic adventure in a fantasy realm like no other? Welcome to RuneScape, a timeless MMORPG that has captivated millions of players around the world for decades.
In RuneScape, you have the freedom to shape your destiny. Will you become a fearless warrior, a masterful mage, or a cunning rogue? With a vast open world to explore, countless quests to complete, and an ever-evolving storyline, the choices are yours.
DESCRIPTION
  domain_name = module.home_arcanum_hosting.domain_name
  # domain_name = module.terrahouse_aws.cloudfront_url
  town = "gamers-grotto"
  content_version = var.arcanum.content_version
}

module "home_payday_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.payday.public_path
  content_version = var.payday.content_version
}

resource "terratowns_home" "home_payday" {
  name = "Making your CLIFFF Bar"
  description = <<DESCRIPTION
Oops, ClifBars for the win actually!
DESCRIPTION
  domain_name = module.home_payday_hosting.domain_name
  town = "melomaniac-mansion"
  content_version = var.payday.content_version
}
