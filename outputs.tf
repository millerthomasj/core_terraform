output "vpc_id" {
  value = "${var.vpc_id}"
}

output "route53_zone_local" {
  value = "${aws_route53_zone.local.name}"
}

output "route53_zone_local_id" {
  value = "${aws_route53_zone.local.zone_id}"
}

output "private_dns_zone" {
  value = "${data.template_file.domain_local.rendered}"
}

output "private_cert" {
  value = "${data.aws_acm_certificate.portals_cert_private.arn}"
}

output "public_cert" {
  value = "${data.aws_acm_certificate.portals_cert_public.arn}"
}

output "dns_zone" {
  value = "${data.template_file.domain.rendered}"
}

output "route53_zone_public_id" {
  value = "${aws_route53_zone.public.zone_id}"
}

output "private_subnet_ids" {
  value = "${data.aws_subnet_ids.private_subnets.ids}"
}

output "public_subnet_ids" {
  value = "${data.aws_subnet_ids.public_subnets.ids}"
}

output "ssh_traffic_sg" {
  value = "${data.terraform_remote_state.security_groups.sg_ssh_internal}"
}

output "monitoring_traffic_sg" {
  value = "${data.terraform_remote_state.security_groups.sg_monitoring}"
}

output "web_traffic_sgs" {
  value = ["${data.terraform_remote_state.security_groups.sg_web}"]
}

output "devphase" {
  value = "${var.devphase["${var.env}"]}"
}

output "stack" {
  value = "${var.stack}"
}

output "careportals_dns_zone" {
  value = "${aws_route53_zone.care_portals.name}"
}

output "careportals_cert" {
  value = "${join(",",data.aws_acm_certificate.careportals_cert.*.arn)}"
}

output "db_subnet_group" {
  value = "${aws_db_subnet_group.db_subnet_group.id}"
}

output "deploy_key" {
  value = "${var.deploy_key_name}"
}

output "current_instances" {
  value = "${var.current_instances}"
}
