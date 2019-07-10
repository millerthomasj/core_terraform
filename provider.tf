terraform {
  backend "s3" {
    key = "core/core.tfstate"
  }
}

provider "aws" {
  region = "${var.region}"
}

data "terraform_remote_state" "security_groups" {
  backend = "s3"

  config {
    bucket = "${var.bucket}"
    key    = "core/sgs.tfstate"
    region = "${var.region}"
  }
}

provider "vault" {
  address = "https://vault.portals.${var.env}.local"
}