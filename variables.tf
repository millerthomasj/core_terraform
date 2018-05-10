variable "bucket" {}
variable "region" {}
variable "vpc_id" {}
variable "environment" {}
variable "project" { default = "portals" }
variable "public_subnet_filter" {}
variable "private_subnet_filter" {}

variable "bastion_internal" { default = false }
variable "bastion_nat_ip" { default = "" }

## Adding for portal ops compliance
variable "devphase" {
  type = "map"
  default = {
    dev = "dev"
    enguat = "uat"
    engqa = "qa"
    engprod = "eng"
    stage = "stg"
    prod = "prd"
  }
}

variable "stack" {
  type = "map"
  default = {
    dev = "tportal"
    enguat = "tportal"
    engqa = "qa"
    engprod = "tportal"
    stage = "tportal"
    prod = "tportal"
  }
}
