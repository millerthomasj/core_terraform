data "aws_route53_zone" "local" {
  name            = "${var.project}.${var.environment}.local."
  private_zone    = true
}

data "aws_route53_zone" "public" {
  name            = "${var.project}.${var.environment}-spectrum.net."
  private_zone    = false
}

resource "aws_route53_record" "bastion_local" {
  name    = "bastion"
  zone_id = "${data.aws_route53_zone.local.zone_id}"
  type    = "A"

  alias {
    name    = "${aws_elb.bastion_elb.dns_name}"
    zone_id = "${aws_elb.bastion_elb.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "bastion_public" {
  count  = "${var.environment == "prod" || var.environment == "stage" ? 0 : 1}"
  name    = "bastion"
  zone_id = "${data.aws_route53_zone.public.zone_id}"
  type    = "A"
  ttl     = "60"
  records = [ "${var.bastion_nat_ip}" ]
}

data "template_file" "public_dns_prod" {
  template = "$${dnsZone}"
  vars {
    dnsZone = "${var.project}.spectrum.net"
  }
}

data "template_file" "public_dns_nonprod" {
  template = "$${dnsZone}"
  vars {
    dnsZone    = "${var.project}.${var.environment}-spectrum.net"
  }
}
