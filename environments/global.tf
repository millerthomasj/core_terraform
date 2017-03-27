data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = {
    bucket = "${var.vpc_state_bucket}"
    key    = "${var.vpc_state_path}"
    region = "${var.region}"
  }
}
