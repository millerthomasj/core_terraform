data "terraform_remote_state" "envstate" {
  backend = "local"

  config {
    path = "${var.env}.tfstate"
  }
}

provider "aws" {
  region = "${var.region}"
}
