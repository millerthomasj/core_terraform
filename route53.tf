resource "aws_route53_zone" "local" {
  name = "${data.template_file.domain_local.rendered}."
  comment = "Zone for hosting all local portals apps."

  force_destroy = true

  vpc {
    vpc_id = "${var.vpc_id}"
  }

  tags = {
    "Name"        = "${data.template_file.domain_local.rendered}"
    "Terraform"   = "true"
    "Environment" = "${var.env}"
    "Project"     = "portals"
  }
}

resource "aws_route53_zone" "public" {
  name = "${data.template_file.domain.rendered}."
  comment = "Zone for hosting all external portals apps."

  force_destroy = true

  tags = {
    "Name"        = "${data.template_file.domain.rendered}."
    "Terraform"   = "true"
    "Environment" = "${var.env}"
    "Project"     = "portals"
  }
}

# --------------------------------------------------------------------------------------------------
# Careportals

resource "aws_route53_zone" "care_portals" {
  name = "portals-${var.env}.${var.care-portals_dns_zone}"
  comment = "Zone for hosting names for care portals"

  force_destroy = true

  tags = {
    "Name"        = "portals-${var.env}.${var.care-portals_dns_zone}"
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
