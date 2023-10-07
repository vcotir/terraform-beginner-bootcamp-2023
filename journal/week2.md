# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby
### Bundler 

Bundler is a package manager for Ruby. It is the primary way to install Ruby packages (aka gems) for Ruby.

#### Install Gems
You need to create a Gemfile and define your gems in that file

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you must run the `bundle install` command to install the gems on the system globally (nodejs installs packages in palce in a the CWD called `node_modules`).

A Gemfile.lock will be created to lock down the gem versions used in the project.

#### Executing Ruby scripts in the context of bundler

We must use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra
Sinatra is a micro web-framework for Ruby to build web-apps.

It's great for mock or development servers or for very simple projects.

You can create a web-server with a single command.

https://sinatrarb.com/

### Misc Packages
* rake is like make
* pry - breakpoints
* activerecord - ORM for validations

## Terratowns Mock Server 

### Running the web server 
We can run the webserver by executing the following commands:
```rb
bundle install
bundle exec ruby server.rb 
```

All code for our server is stored in [server.rb](../terratowns_mock_server/server.rb)

## Terraform Log Levels

Different log levels from running Terraform can be outputed.

These can be altered via [env vars](https://developer.hashicorp.com/terraform/internals/debugging).