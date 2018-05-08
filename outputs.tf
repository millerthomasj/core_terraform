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
