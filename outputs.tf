output "vpc_id" {
  value = "${var.vpc_id}"
}

output "route53_zone_local" {
  value = "${data.aws_route53_zone.local.name}"
}

output "route53_zone_local_id" {
  value = "${data.aws_route53_zone.local.zone_id}"
}

output "route53_zone_public" {
  value = "${data.aws_route53_zone.public.name}"
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

output "sg_ssh_pa" {
  value = "${data.aws_security_group.ssh_pa.id}"
}

output "sg_ssh_elb" {
  value = "${data.aws_security_group.ssh_elb.id}"
}

output "sg_ssh_bastion" {
  value = "${data.aws_security_group.ssh_bastion.id}"
}

output "devphase" {
  value = "${var.devphase["${var.environment}"]}"
}

output "stack" {
  value = "${var.stack["${var.environment}"]}"
}
