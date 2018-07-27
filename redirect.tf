resource "aws_s3_bucket" "redirects_bucket" {
  
  # checks if env is 'engprod'. If so set count = 1, else count = 0
  count = "${var.env == "engprod" ? 1 : 0}"

  bucket = "portals.redirect.spectrum.net"
  region = "${var.region}"
  acl    = "public-read"

  tags {
    Project = "${var.project_name}"
    Enviroment = "${var.env}"
    Terraform = true
    Application = "spectrumtv"
    Name = "${var.env} Terraform redirect bucket"
  }

  website {
    redirect_all_requests_to = "https://www.spectrum.net"
  }
}
