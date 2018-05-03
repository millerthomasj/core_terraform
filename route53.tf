data "aws_route53_zone" "portals" {
  name            = "portals.${var.environment}.local."
  private_zone    = true
}

resource "aws_route53_record" "bastion" {
  zone_id = "${data.aws_route53_zone.portals.zone_id}"
  name    = "bastion"
  type    = "A"

  alias {
    name    = "${aws_elb.bastion_elb.dns_name}"
    zone_id = "${aws_elb.bastion_elb.zone_id}"
    evaluate_target_health = true
  }
}
