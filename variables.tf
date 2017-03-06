## declare all the env-specific variables that are defined in *.tfvars

variable "env" { } 
variable "name" { } 

variable "azs" { }
variable "cidr" { } 
variable "instance_type" { } 

variable "public_subnets" { } 
variable "private_subnets" { } 

variable "subdomain_int_name" { } 
variable "subdomain_ext_name" { } 

## declare global variables

provider "aws" {
    region = "us-west-1"
}

variable "state_bucket_name" { default = "eos-terraform-state" }
variable "global_state_file" { default = "global.tfstate" }
variable "prod_state_file" { default = "production.tfstate" } # TODO: make init.sh use these variables
variable "staging_state_file" { default = "staging.tfstate" }
variable "development_state_file" { default = "development.tfstate" }

variable "region" { default = "us-west-1" }
variable "acct_number" { default = "" }

# VPC specific variables
variable "enable_dns_hostnames" { default = "true" }
variable "enable_dns_support" { default = "true" }
variable "enable_nat_gateway" { default = "true" }
variable "map_public_ip_on_launch" { default = "false" }
variable "private_propagating_vgws" {
  type     = "list"
  default = [""]
}
variable "public_propagating_vgws" {
  type     = "list"
  default = [""]
}
variable "tags" {
  type     = "list"
  default = ["terraform"]
}
