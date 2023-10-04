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


