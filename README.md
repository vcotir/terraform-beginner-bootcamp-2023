# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project will utilize semantic versioning for its tagging.
[https://semver.org/](https://semver.org/)

The general format: 
**MAJOR.MINOR.PATCH**, e.g. `1.0.1`
- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI
### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest CLI instructions via Terraform Documentation and change the scripting for install.

The bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpgp deprecation issues we noticed that the bash scripts were a considerable amount more code. So we decied to create a bash script to install the Terraform CLI.

Benefits:
- This will keep the Gitpod Task ([.gitpod.yml](.gitpod.yml)) file tidy
- Will allow us an easier to debug

### Considerations for Linux Distribution
This project is built against Ubuntu. Please consider checking your Linux Distribution and change accordingly to your distributino needs
[How to Check OS Version on Linux](https://linuxize.com/post/how-to-check-linux-version/)

Example of checking OS version:
```
lsb_release -a

Distributor ID: Ubuntu
Description:    Ubuntu 22.04.3 LTS
Release:        22.04
Codename:       jammy
```

#### Shebang
A Shebang (pronounced Sha-bang) tells the bash script what program will interpret the script.

ChatGPT will recommended this format for bash: `#!/usr/bin/env bash`

Benefits:
- For portability for different OS distributions
- Will search user's PATH for bash executable

[Documentation](https://en.wikipedia.org/wiki/Shebang_(Unix))

### Execution Considerations
When executing bash script we can use the `./` shorthand notation to execute the bash script

e.g. `./bin/install_terraform_cli`

If using script in `.gitpod.yml` we must point the script to a program that will interpret it.

e.g. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations
In order to execute our bash scripts, we must change the permissions to allow for that

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:
```sh
chmod 744 ./bin/install_terraform_cli
```

> Note: AWS won't let you use SSH keys unless you make them read only

### Gitpod Lifecycle (Before, Init, Command)
We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

https://en.wikipedia.org/wiki/Chmod

### Working with Env Vars
We can list out all Environment Variables (Env Vars) using the `env` command

We can filter specific env vars using grep e.g. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

We can unset using `unset HELLO`

WE can set an inline env variable temporarily running the command:
`HELLO='world' ./bin/print_message`

Within a bash script we can set env var without writing export e.g..
```sh
#!/usr/bin/env bash

HELLO='world'
echo $HELLO
```

#### Printing Vars
We can print an env var using echo e.g. `echo $HELLO`.

#### Scoping of Env Vars
New shell environments will not be aware of env vars set in other shell environments. 

To persist env vars, you must set env vars in your bash profile e.g. `.bash_profile`

#### Persisting Env Vars in Gitpod
We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

After doing so, all future workspaces will set the env vars with the gitpod env vars.

### AWS CLI installation
AWS CLI is installed for the project via the bash script [./bin/install_aws_cli](./bin/install_aws_cli)

#### Very important AWS CLI command
We can check if AWS credentials is configured correctly by using the following command:

```sh
aws sts get-caller-identity
```

If it is successful, you should see a json payload that looks like: 

```json
{
    "UserId": "AIDAW6MOOZM12345678",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generated AWS CLI from IAM user in order to use AWS CLI

[Installing AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[Env vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

## Terraform Basics

### Terraform Registry
Terraform sources their providers and modules from the Terraform registry which is located at [https://registry.terraform.io/](https://registry.terraform.io/).

- **Providers** are interfaces to APIs that will allow you to create resources in Terraform
- **Module** are a way to make a large amount of Terraform code module, shareable, portable.

### Terraform Console
We can see a list of all Terraform commands by typing `terraform`.

### Terraform Init
At the start of a new Terraform project we will run `terraform init` to donwload binaries for the Terraform providers that will be used for the project.

[An example of a Terraform provider](https://registry.terraform.io/providers/hashicorp/random/latest)

### Terraform Plan
> `terraform plan` 
This will generate a changeset about the state of our infrastructure and what will be changed.

We can output this changeset i.e. "plan" ot be passed to apply. But often, output can be ignored.

### Terraform Apply
> `terraform apply`

This will run a plan, passing in changeset to be execute by Terraform. Apply should prompt yes or no.

A plan can be autoapproved with the following command: 
> `terraform apply --auto-approve`

#### Terraform Destroy
`terraform destroy`
This will destroy resources.

Can also use auto approve flag to speed up deprovisioning of resources.

`terraform destroy --auto-approve`

#### Terraform Lock Files
`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform Lock file should be commited to Version Control System.

### Terraform State Files
`.terraform.tfstate` contains information about the current state of your infrastructure.

This file contains sensitive data and **should not be committed* to your VCS.
Losing this file means losing known state of infrastructure.

`.terraform.tfstate.backup` is the previous state of the infrastructure.
https://registry.terraform.io/providers/hashicorp/random/latest/docs

### Terraform Directory
The `.terraform` directory contains binaries of Terraform providers.

### Root Terraform Module
The output section contains information that will be listed off in running [terraform apply](#terraform-apply)

### Using Terraform Random Provider to Create S3 Bucket names
When using this to create S3 buckets, you must make sure to follow [Bucket Naming Rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html). The `lower = true; upper = false` properties for the provider was used to pass the bucket naming rules.

