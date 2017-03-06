#Configure provider
provider "aws" {
  region     = "${var.region}"
  profile    = "${var.env}"
}

module "vpc" {
  source = "github.com/terraform-community-modules/tf_aws_vpc"
  name =  "${var.name}"
  cidr =  "${var.cidr}"
  azs = "${var.azs}"
  private_subnets = "${var.private_subnets}"
  public_subnets = "${var.public_subnets}"
  enable_nat_gateway = "${var.enable_nat_gateway}"
  enable_dns_support = "${var.enable_dns_support}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  tags {
    "Terraform" = "true"
    "Environment" = "${var.env}"
  }
}
