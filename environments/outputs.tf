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
