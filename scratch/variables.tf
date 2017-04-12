## declare all the env-specific variables that are defined in *.tfvars

variable "environment" { default = "scratch" } 
variable "name" { default = "EOS Scratch VPC" } 

variable "azs" { type = "list" }
variable "cidr" { } 

variable "public_subnets" { type = "list" } 
variable "private_subnets" { type = "list" } 

## declare global variables

variable "state_bucket_name" { default = "eos.terraform.scratch" }
variable "group_name" { default = "EOS" }

variable "region" { default = "us-west-1" }

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

# Kubernetes variables
variable "k8s_cluster_name" { default = "kubernetes" }
variable "k8s_state_path" { default = "vpc/kubernetes" }
variable "k8s_version" { default = "1.6.1" }
variable "k8s_master_size" { default = "t2.medium" }
variable "k8s_node_size" { default = "t2.medium" }
variable "k8s_node_count" { default = "3" }
