terraform {
  backend "s3" {
    bucket = "eos.terraform.state"
    key    = "core/core.tfstate"
  }
}

provider "aws" {
  region     = "${var.region}"
  profile    = "${var.environment}"
}
