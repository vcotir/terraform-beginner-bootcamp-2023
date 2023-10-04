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


[Standard Structure of a Terraform Project](https://developer.hashicorp.com/terraform/language/modules/develop/structure)


