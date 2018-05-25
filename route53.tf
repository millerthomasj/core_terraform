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
    evaluate_target_health = true
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
