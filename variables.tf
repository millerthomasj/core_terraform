## declare all the env-specific variables that are defined in *.tfvars

variable "project_name" { default = "eos" }
variable "region" { default = "us-west-1" }
variable "environment" { } 
variable "availability_zones" { type = "list" }
variable "vpc_id" { }
variable "private_subnet_ids" { type = "list" }
variable "public_subnet_ids" { type = "list" }
variable "private_subnet_cidrs" { type = "list" }
variable "public_subnet_cidrs" { type = "list" }

## declare global variables

variable "state_bucket_name" { default = "eos.terraform.state" }
variable "group_name" { default = "EOS" }
variable "dns_zone" { default = "eos.local" }

# 56nat.mystrotv.com
variable "allow_vpn" { default = "207.93.212.56/32" }

# Consul specific variables
#variable "consul_version" {}
#variable "consul_servers_min" {}
#variable "consul_servers_max" {}
#variable "consul_servers_desired" {}
#variable "consul_key" {}
