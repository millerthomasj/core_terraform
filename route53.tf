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
# the app-specific entries below are here to address the chicken & egg scenario of
# needing a subdomain to exist to be able to create NS entries in the parent domain

# Careportals
resource "aws_route53_zone" "care_portals" {
  name = "${data.template_file.domain_careportals.rendered}"
  comment = "Zone for hosting names for care portals"

  force_destroy = true

  tags = {
    "Name"        = "${data.template_file.domain_careportals.rendered}"
    "Terraform"   = "true"
    "Environment" = "${var.env}"
    "Project"     = "portals"
  }
}

# SpectrumBusiness
resource "aws_route53_zone" "spectrum_business" {
  name = "${data.template_file.domain_sbnet.rendered}."
  comment = "Zone for hosting names for sbnet portals"

  force_destroy = true

  tags = {
    "Name"        = "${data.template_file.domain_sbnet.rendered}"
    "Terraform"   = "true"
    "Environment" = "${var.env}"
    "Project"     = "portals"
  }
}
