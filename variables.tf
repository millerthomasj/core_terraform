## declare all the env-specific variables that are defined in *.tfvars

variable "environment" { } 
variable "name" { } 

variable "azs" { type = "list" }
variable "cidr" { } 
variable "instance_type" { } 

variable "public_subnets" { type = "list" } 
variable "private_subnets" { type = "list" } 

## declare global variables

# 56nat.mystrotv.com
variable "allow_vpn" { default = "207.93.212.56/32" }
variable "state_bucket_name" { default = "eos-terraform-state" }
variable "group_name" { default = "EOS" }

variable "region" { default = "us-west-1" }
variable "acct_number" { default = "" }

# VPC specific variables
variable "vpc_module_ref" { default = "v1.0.2" }
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

# Consul specific variables
variable "consul_version" {}
variable "consul_servers_min" {}
variable "consul_servers_max" {}
variable "consul_servers_desired" {}
variable "consul_key" {}
