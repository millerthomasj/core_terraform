output "environment" {
  value = "${var.environment}"
}

output "region" {
  value = "${var.region}"
}

output "azs" {
  value = [ "${var.azs}" ]
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "internal_dns_zone_id" {
  value = "${aws_route53_zone.local_zone.zone_id}"
}

output "internal_dns_name" {
  value = "${aws_route53_zone.local_zone.name}"
}

output "consul_url" {
  value = "${module.consul-ecs.dns_name}"
}
