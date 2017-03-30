resource "aws_s3_bucket" "state" {
  bucket = "eos.terraform.state"
  acl    = "private"

  versioning {
    enabled = true
  }
 
  tags {
    Name = "EOS Terraform State Bucket"
    Terraform = true
    Project = "EOS"
  }
}
