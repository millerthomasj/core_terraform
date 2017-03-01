variable access_key  {}
variable secret_key {}
variable "region" {
  default = "us-west-1"
}

variable "availability_zone" {
  default = "us-west-1b"
}
variable "vpc_name" {
  default = "my-vpc"
}
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "public_cidr_block" {
  default = "10.0.1.0/24"
}
variable "private_cidr_block" {
  default = "10.0.2.0/24"
}
