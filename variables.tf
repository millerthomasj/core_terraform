#variables for provider and state

variable "region" {
  default = "us-west-1"
}

variable "availability_zone" {
  default = "us-west-1b"
}

variable profile {
  default = "scratch"
}

variable state_bucket_name {
  default = "eos-terraform-state"
}

variable state_key_path {
  default = "vpc.tfstate"
}

#variables for VPC module (https://github.com/terraform-community-modules/tf_aws_vpc)
variable "name" {
  default = "EOS VPC"
}
variable "cidr" {
  default = "10.0.0.0/16"
}
variable "public_subnets" {
  type     = "list"
  default = ["10.0.1.0/24"]
}
variable "private_subnets" {
  type     = "list"
  default = ["10.0.2.0/24"]
}

variable "azs" {
  type     = "list"
  default = ["us-west-1b"]
}

variable "enable_dns_hostnames" {
  default = "true"
}

variable "enable_dns_support" {
  default = "true"
}

variable "enable_nat_gateway" {
  default = "true"
}

variable "map_public_ip_on_launch" {
  default = "false"
}

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
  default = [""]
}
