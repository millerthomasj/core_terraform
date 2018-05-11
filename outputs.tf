output "vpc_id" {
  value = "${var.vpc_id}"
}

output "route53_zone_local" {
  value = "${data.aws_route53_zone.local.name}"
}

output "route53_zone_local_id" {
  value = "${data.aws_route53_zone.local.zone_id}"
}

output "private_dns_zone" {
  value = "${var.project}.${var.environment}.local"
}

output "private_cert" {
  value = "${data.aws_acm_certificate.portals_cert_private.arn}"
}

output "public_cert" {
  value = "${data.aws_acm_certificate.portals_cert_public.arn}"
}

output "dns_zone" {
  value = "${var.environment == "prod" ? data.template_file.public_dns_prod.rendered : data.template_file.public_dns_nonprod.rendered}"
}

output "route53_zone_public_id" {
  value = "${data.aws_route53_zone.public.zone_id}"
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
  value = [
           "${data.terraform_remote_state.security_groups.sg_web}"
          ]
}

output "devphase" {
  value = "${var.devphase["${var.environment}"]}"
}

output "stack" {
  value = "${var.stack["${var.environment}"]}"
}
