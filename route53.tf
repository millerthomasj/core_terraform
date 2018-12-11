data "aws_route53_zone" "local" {
  name         = "${data.template_file.domain_local.rendered}."
  private_zone = true
}

data "aws_route53_zone" "public" {
  name         = "${data.template_file.domain.rendered}."
  private_zone = false
}

# --------------------------------------------------------------------------------------------------
# Careportals

resource "aws_route53_zone" "care_portals" {
  name = "portals-${var.env}.${var.care-portals_dns_zone}"
  comment = "Zone for hosting names for care portals"

  force_destroy = true

  tags = {
    "Name"        = "aws-${var.env}.${var.care-portals_dns_zone}"
    "Terraform"   = "true"
    "Environment" = "${var.env}"
    "Project"     = "portals"
  }
}

# --------------------------------------------------------------------------------------------------
# SpectrumBusiness

resource "aws_route53_zone" "spectrum_business" {
  name = "${var.env == "prod" ? data.template_file.domain_prod_sbnet.rendered : data.template_file.domain_nonprod_sbnet.rendered}"
  comment = "Zone for hosting names for sbnet portals"

  force_destroy = true

  tags = {
    "Name"        = "${var.env == "prod" ? data.template_file.domain_prod_sbnet.rendered : data.template_file.domain_nonprod_sbnet.rendered}"
    "Terraform"   = "true"
    "Environment" = "${var.env}"
    "Project"     = "portals"
  }
}
