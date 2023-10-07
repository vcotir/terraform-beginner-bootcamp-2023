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
  name = "AI Ramblings and Musings"
  description = <<DESCRIPTION
In our fast-paced world, Artificial Intelligence (AI) emerges as a beacon of hope, promising solutions that save time and empower individuals to regain control over their lives. AI's ability to process vast data, learn, and adapt empowers us in extraordinary ways.

Imagine AI-driven healthcare diagnostics that swiftly detect diseases, potentially saving lives and reducing stress. Picture AI-driven personal assistants that efficiently manage tasks, allowing us to focus on what truly matters. With AI in education, tailored learning experiences put the reins of knowledge back in our hands.

In industries, AI-driven automation enhances efficiency, reducing workloads and granting professionals more time for creativity and strategic pursuits. In transportation, AI optimizes routes, reducing congestion and giving us precious moments for leisure or productivity.

By entrusting repetitive tasks to AI, we reclaim invaluable time and mental space. AI's predictive capabilities help us make informed decisions and anticipate challenges. Embracing AI means taking back control of our lives, where we have more time to dream, create, and savor the moments that truly matter.
DESCRIPTION
  domain_name = module.home_devops_dungeon_hosting.domain_name
  town = "gamers-grotto"
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
