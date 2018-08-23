resource "aws_s3_bucket" "state" {
  bucket = "${var.bucket}"
  region = "${var.region}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags {
    Name = "${var.env} Terraform state bucket"
    Terraform = true
    Project = "${var.project}"
  }
}
