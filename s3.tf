resource "aws_s3_bucket" "backups" {
  bucket = "${var.project}.backups.${var.env}"
  acl    = "private"

  tags {
    Name = "backups bucket"
    Terraform = true
    Project = "${var.project}"
    Environment = "${var.env}"
    creator = "${var.dl_name}"
  }
}
