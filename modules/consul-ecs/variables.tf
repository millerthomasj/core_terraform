## declare all the env-specific variables that are defined in *.tfvars

variable "project" { }
variable "environment" { } 
variable "vpc" { } 
variable "region" { } 
variable "private_subnets" { type = "list" }
variable "instance_type" { default = "t2.small" }
variable "ami" {
  default = {
    us-west-1 = "ami-dd104dbd"
  }
}
variable "keypair" {
  default = "tomtest"
}

variable "zones" { type = "list" }

variable "consul_servers_min" { default = 3 }
variable "consul_servers_max" { default = 5 }
variable "consul_servers_desired" { default = 3 }

# To be used to find consul servers
variable "uniquekey" { }
