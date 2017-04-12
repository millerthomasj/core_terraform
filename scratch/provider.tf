terraform {
  backend "s3" {
    key    = "vpc/vpc.tfstate"
  }
}

provider "aws" {
  region     = "${var.region}"
  profile    = "${var.environment}"
}
