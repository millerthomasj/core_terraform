data "aws_acm_certificate" "portals_cert_public" {
  domain = "*.${data.template_file.domain.rendered}"
}

data "aws_acm_certificate" "portals_cert_private" {
  domain = "*.${var.project}.${var.env}.local"
  most_recent = true
}
