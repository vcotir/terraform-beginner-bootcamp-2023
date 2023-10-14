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

module "home_devops_dungeon_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.devops_dungeon.public_path
  content_version = var.devops_dungeon.content_version
}

resource "terratowns_home" "home_devops_dungeon" {
  name = "Demon Slayer is The BEST!"
  description = <<DESCRIPTION
Are you a fan of Demon Slayer: Kimetsu no Yaiba, the epic manga and anime series that follows the adventures of Tanjiro Kamado and his sister Nezuko as they fight against the demons that threaten humanity? Do you want to learn more about the characters, the story, and the world of Demon Slayer? Do you want to share your thoughts, opinions, and fan art with other fans of the series?

If you answered yes to any of these questions, then you should visit my Demon Slayer anime fan page! It’s a place where you can find all kinds of information, news, trivia, and fun content related to Demon Slayer. You can also interact with other fans, join discussions, participate in polls, and show your support for your favorite characters and scenes. It’s a community of passionate and friendly people who love Demon Slayer as much as you do!

So what are you waiting for? Come and join my Demon Slayer anime fan page today! You won’t regret it!
DESCRIPTION
  domain_name = module.home_devops_dungeon_hosting.domain_name
  town = "video-valley"
  content_version = var.devops_dungeon.content_version
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
