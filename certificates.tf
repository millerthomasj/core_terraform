data "template_file" "portals_cert_prod" {
  template = "*.$${dnsZone}"
  vars {
    dnsZone = "${var.project}.spectrum.net"
  }
}

data "template_file" "portals_cert_nonprod" {
  template = "*.$${dnsZone}"
  vars {
    dnsZone    = "${var.project}.${var.environment}-spectrum.net"
  }
}

data "aws_acm_certificate" "portals_cert_public" {
  domain = "${var.environment == "prod" ? data.template_file.portals_cert_prod.rendered : data.template_file.portals_cert_nonprod.rendered}"
}

data "aws_acm_certificate" "portals_cert_private" {
  domain = "*.${var.project}.${var.environment}.local"
}
