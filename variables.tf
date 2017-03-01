#variables for provider and state

variable "region" {
  default = "us-west-1"
}

variable state_bucket_name {
  default = "eos-terraform-state"
}
variable state_key_path {
  default = "terraform.tfstate"
}
variable state_profile_name {
  default = "default"
}


#variables for
variable "availability_zone" {
  default = "us-west-1b"
}
variable "vpc_name" {
  default = "EOS Scratch VPC"
}
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "public_cidr_block" {
  default = "10.0.1.0/24"
}
variable "public_subnet_name" {
  default = "Public Subnet"
}
variable "private_cidr_block" {
  default = "10.0.2.0/24"
}
variable "private_subnet_name" {
  default = "Private Subnet"
}
