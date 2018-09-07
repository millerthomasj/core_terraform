data "aws_route53_zone" "local" {
  name         = "${data.template_file.domain_local.rendered}."
  private_zone = true
}

data "aws_route53_zone" "public" {
  name         = "${data.template_file.domain.rendered}."
  private_zone = false
}

resource "aws_route53_record" "bastion_local" {
  name    = "bastion"
  zone_id = "${data.aws_route53_zone.local.zone_id}"
  type    = "A"

  alias {
    name                   = "${aws_elb.bastion_elb.dns_name}"
    zone_id                = "${aws_elb.bastion_elb.zone_id}"
    evaluate_target_health = false
  }
}

# CSE's Palo Router cannot resolve internal VPC DNS
resource "aws_route53_record" "bastion_internal_public" {
  name    = "bastion-internal"
  zone_id = "${data.aws_route53_zone.public.zone_id}"
  type    = "A"

  alias {
    name                   = "${aws_elb.bastion_elb.dns_name}"
    zone_id                = "${aws_elb.bastion_elb.zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "bastion_public" {
  count   = "${var.env == "prod" || var.env == "stage" ? 0 : 1}"
  name    = "bastion"
  zone_id = "${data.aws_route53_zone.public.zone_id}"
  type    = "A"
  ttl     = "60"
  records = ["${var.bastion_nat_ip}"]
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


# SpectrumBusiness

resource "aws_route53_zone" "spectrum_business" {
  name = "portals.${var.env}-${var.sbnet-portals_dns_zone}"
  comment = "Zone for hosting names for sbnet portals"

  force_destroy = true

  tags = {
    "Name"        = "aws-${var.env}.${var.sbnet-portals_dns_zone}"
    "Terraform"   = "true"
    "Environment" = "${var.env}"
    "Project"     = "portals"
  }
}
