data "aws_acm_certificate" "portals_cert_public" {
  domain = "*.${data.template_file.domain.rendered}"
}

data "aws_acm_certificate" "portals_cert_private" {
  domain = "*.${var.project}.${var.env}.local"
}

data "aws_acm_certificate" "careportals_cert" {
  domain = "careportals.portals-${var.env}.${var.care-portals_dns_zone}"
}