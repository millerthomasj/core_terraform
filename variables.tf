# common vars
variable "project"  { default = "portals" }
variable "bucket"   { }
variable "region"   { default = "us-east-1" }
variable "env"      { }
variable "dl_name"  { default = "DL-SEDevOps-Portals@charter.com" }

# instance types, for better management of new instance generations
variable "current_instances" {
  type = "map"
  default = {
    t_nano = "t2.nano"
    t_micro = "t2.micro"
    t_small = "t2.small"
    t_medium = "t2.medium"
    t_large = "t2.large"
    # m-class medium instances were phased out with m4.
    # m3.medium is the last m.medium instance available
    m_medium = "m3.medium"
    # m5 not available in us-east-1 as of March 19
    m_large = "m4.large"
    m_xlarge = "m4.xlarge"
    cache_small = "cache.t2.small"
    cache_medium = "cache.t2.medium"
    cache_large = "cache.m4.large"
    # cache.m4.xlarge costs the same as m5 but with more RAM for caching
    cache_xlarge = "cache.m4.xlarge"
    db_small = "db.t2.small"
    db_medium = "db.t2.medium"
    db_large = "db.m4.large"
    db_xlarge = "db.m4.xlarge"
    db_2xlarge = "db.m4.2xlarge"
  }
}

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
variable "stack"                { default = "tportal" }
variable "careportals_dns_zone" { default = "timewarnercable.com" }
variable "sbnet_dns_zone"       { default = "spectrumbusiness.net" }
