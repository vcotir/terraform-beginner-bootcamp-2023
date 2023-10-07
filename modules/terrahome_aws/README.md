## Terrahome AWS

```tf
module "home_arcanum" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.arcanum_public_path
  content_version = var.content_version
}
```

Public directory expects the following:
- index.html
- error.html
- assets

All top level files will be copied, but not directories