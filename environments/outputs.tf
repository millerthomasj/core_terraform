output "vpc_id" {
  value = "${var.vpc_id}"
}

output "dns_zone" {
  value = "${aws_route53_record.local_ns.fqdn}"
}

output "availability_zones" {
  value = "${join(",", var.availability_zones)}"
}

output "ns_cicd" {
  value = "${kubernetes_namespace.cicd.metadata.0.name}"
}
