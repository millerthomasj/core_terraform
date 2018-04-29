output "private_subnet_ids" {
  value = "${data.aws_subnet_ids.private_subnets.ids}"
}

output "public_subnet_ids" {
  value = "${data.aws_subnet_ids.public_subnets.ids}"
}
