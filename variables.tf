# common vars
variable "project"  { default = "portals" }
variable "bucket"   { }
variable "region"   { default = "us-east-1" }
variable "env"      { }
variable "dl_name"  { default = "DL-SEDevOps-Portals@charter.com" }

# VPC & subnet vars
variable "vpc_id"                { }
variable "public_subnet_filter"  { default = "portals*elb*" }
variable "private_subnet_filter" { default = "portals*app*" }

# bastion vars
variable "instance_type"         { default = "t2.small" }
variable "deploy_key_name"       { default = "deploy" }
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
variable "sbnet_dns_zone"        { default = "spectrumbusiness.net" }
