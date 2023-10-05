# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure
Our root module structure is as follows:

```
PROJECT_ROOT
|-- main.tf            # everything else
|-- variables.tf       # stores structure of input variables
|-- providers.tf       # defines required providers and configs
|-- outputs.tf         # stores our outputs
|-- terraform.tfvars   # data of variables we want to load into Terraform project
|-- README.md          # required for root modules
```
## Fixing Tags
[How to Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Delete a tag on local
```sh
$ git tag -d <tag_name>
```

Remotely delete a tag
```sh
git push --delete origin tagname
```

Checkout the commit you'd like to retag. Grab the Sha hash from your github history.

```sh
git checkout <SHA>
git tag M.N.P
git push --tags
git checkout main
```


## Terraform Variables

### Terraform Cloud Variables

In terraform, we can set two kinds of variables:
- Environment Variables - those you would set in your bash terminal e.g. AWS credentials
- Terraform Variables - those used in tfvars files

We can set Terraform Cloud variables to be sensitive in via the Terraform UI.

## Loading Terraform Input Variables
[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
The `-var` flag in `tf` can be used to set an input variable or override a variable in the tfvars file e.g. `tf -var user-uuid="uuid here"`

### var-file flag
- TODO: research this flag

### terraform.tfvars
Default file that's loaded as terraform variables

### auto.tfvars
- TODO: document this functionality for terraform cloud

### Order of Precedence for Terraform Variables
- TODO - document which terraform variables take precedence

## Dealing with Configuration Drift
## What happens if we lose our state file?

If the statefile is lost, you will most likely have to tear down your cloud infrastructure manually. 

Terraform import can be used but it won't work for all resources. Check Terraform provider documentation for the support.

### Fix Missing Resources with Terraform Import

Use import via CLI to import resources into state.

e.g. `terraform import aws_s3_bucket.bucket <bucket name>`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#bucket)

### Fix Manual Configuration
If someone goes and deletes or modifies cloud resource manually through ClickOps.

If we run Terraform plan, it will attempt to put the infrastructure back into the expected state to fix Configuration Drift.


[Standard Structure of a Terraform Project](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Fix using Terraform Refresh
```sh
terraform apply -refresh-only --auto-approve
```

## Terraform Modules
Using the source, we can import the module from various places e.g.
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid 
  bucket_name = var.bucket_name
}
```

## Terraform Modules

### Terraform Module Structure
It is recommended to place modules in the `modules` directory when locally development modules. But they can be named whatever you like

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the Terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid 
  bucket_name = var.bucket_name
}
```

### Modules Sources
[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

LLMs may not be trained on latest documentation or information about Terraform.

It may likely produce older examples that may be deprecated.

Terraform want you to use provisioners.

## Working with Files in Terraform

### Fileexists function
This is a terraform built-in function to check for the existence of a file

```tf
condition     = fileexists(var.error_html_filepath)
```

### FileMD5
When pushing files to S3 as objects, on a second terraform apply the file data won't be checked and thus the file will not be reuploaded. We must push an etag to S3 objects so that it can be checked by Terraform for data changes. 

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  // Data isn't checked!
  source = var.index_html_filepath

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.index_html_filepath)
}
```
[Documentation for fileMD5 hashing function - a built-in terraform function](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable

In Terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module of the configuration

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  // Data isn't checked!
  source = var.index_html_filepath

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.index_html_filepath)
}
```
## Terraform Locals

Locals allow us to define local variables.

It can be useful to transform data into another format and have them referenced as a variable within a `.tf` file.

```tf
locals {
    s3_origin_id = "MyS3Origin"
}
```

[Local Values](https://spacelift.io/blog/terraform-locals)


## Terraform Data Sources
This allows us to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them.
```tf
data "aws_caller_identity" "current" {}
```

## Working with JSON

We use jsonencode to create the json policy inline in the HCL.
```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

## Setting Cloudfront Distribution Origin 
In configuring the aws_cloudfront_distribution resource, origin.domain_name should be set to the `bucket_regional_domain_name` of the bucket. Otherwise, redirection will not work properly.

[Cloudfront Distribution Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#example-usage
)

## Changing the Lifecycle of Resources
[Meta Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data
Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

```tf
lifecycle {
    replace_triggered_by = [var.content_version]
  }
```
[Terraform Data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)