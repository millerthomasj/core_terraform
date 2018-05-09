data "aws_route53_zone" "local" {
  name            = "${var.app_name}.${var.environment}.local."
  private_zone    = true
}

data "aws_route53_zone" "public" {
  name            = "${var.app_name}.${var.environment}-spectrum.net."
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
  name    = "bastion"
  zone_id = "${data.aws_route53_zone.public.zone_id}"
  type    = "A"
  ttl     = "60"
  records = [ "69.76.31.11" ]
}
