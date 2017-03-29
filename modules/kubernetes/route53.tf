resource "aws_route53_record" "api-eos-kubernetes-scratch-charter-net" {
  name = "api.eos-kubernetes.scratch-charter.net"
  type = "A"

  alias = {
    name                   = "${aws_elb.api-eos-kubernetes-scratch-charter-net.dns_name}"
    zone_id                = "${aws_elb.api-eos-kubernetes-scratch-charter-net.zone_id}"
    evaluate_target_health = false
  }

  zone_id = "/hostedzone/Z37KR0V4S08L5R"
}

resource "aws_route53_record" "bastion-eos-kubernetes-scratch-charter-net" {
  name = "bastion.eos-kubernetes.scratch-charter.net"
  type = "A"

  alias = {
    name                   = "${aws_elb.bastion-eos-kubernetes-scratch-charter-net.dns_name}"
    zone_id                = "${aws_elb.bastion-eos-kubernetes-scratch-charter-net.zone_id}"
    evaluate_target_health = false
  }

  zone_id = "/hostedzone/Z37KR0V4S08L5R"
}
