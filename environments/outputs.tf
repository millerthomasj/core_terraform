output "internal_dns_zone_id" {
  value = "${aws_route53_zone.local_zone.zone_id}"
}

output "internal_dns_name" {
  value = "${aws_route53_zone.local_zone.name}"
}
