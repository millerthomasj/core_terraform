# common vars
variable "project_name"          { default = "portals" }
variable "bucket"                { }
variable "region"                { default = "us-east-1" }
variable "env"                   { }

# VPC & subnet vars
variable "vpc_id"                { }
variable "public_subnet_filter"  { default = "portals*elb*" }
variable "private_subnet_filter" { default = "portals*app*" }

# bastion vars
variable "bastion_internal"      { default = false }
variable "bastion_nat_ip"        { default = "" }

## Adding for portal ops compliance
variable "devphase" {
  type = "map"
  default = {
    dev = "dev"
    uat = "uat"
    qa = "qa"
    engprod = "eng"
    stage = "stg"
    prod = "prd"
  }
}
variable "stack"                 { default = "tportal" }
variable "care-portals_dns_zone" { default = "timewarnercable.com" }
