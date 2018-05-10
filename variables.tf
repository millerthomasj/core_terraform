variable "region" {}
variable "vpc_id" {}
variable "environment" {}
variable "public_subnet_filter" {}
variable "private_subnet_filter" {}

variable "sgs_bucket_name" {}
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
