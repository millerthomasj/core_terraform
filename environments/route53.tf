data "aws_route53_zone" "primary" {
  name = "${var.dns_zone}"
  
}

resource "aws_route53_zone" "local_zone" {
  name = "${var.project_name}.${data.aws_route53_zone.primary.name}"
  comment = "Hosted Zone for ${var.project_name}"

  force_destroy = true

  tags = {
    "Terraform"   = "true"
    "Environment" = "${var.environment}"
    "Project"     = "${var.project_name}"
  }
}

resource "aws_route53_record" "local_ns" {
  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name    = "${var.project_name}.${data.aws_route53_zone.primary.name}"
  type    = "NS"
  ttl     = "30"

  records = [
    "${aws_route53_zone.local_zone.name_servers.0}",
    "${aws_route53_zone.local_zone.name_servers.1}",
    "${aws_route53_zone.local_zone.name_servers.2}",
    "${aws_route53_zone.local_zone.name_servers.3}",
  ]
}
