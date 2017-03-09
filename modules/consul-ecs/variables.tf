## declare all the env-specific variables that are defined in *.tfvars

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
variable "azs" { type = "list" }
