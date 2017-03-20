output "internal_dns_zone_id" {
  value = "${aws_route53_zone.primary.zone_id}"
}

output "internal_dns_name" {
  value = "${aws_route53_zone.primary.name}"
}
