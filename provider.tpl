terraform {
  backend "s3" {
    key    = "ENV/core/core.tfstate"
  }
}

provider "aws" {
  region = "${var.region}"
}

data "terraform_remote_state" "security_groups" {
  backend = "s3"
  config {
    bucket  = "${var.sgs_bucket_name}"
    key     = "${var.environment}/security_groups.tfstate"
    region  = "${var.region}"
    profile = "${var.environment}"
  }
}
