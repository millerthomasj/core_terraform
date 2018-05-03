terraform {
  backend "s3" {
    key    = "core/core.tfstate"
  }
}

provider "aws" {
  region = "${var.region}"
}
