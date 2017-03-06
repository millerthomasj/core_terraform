output "env" {
  value = "${var.env}"
}

output "region" {
  value = "${var.region}"
}

output "azs" {
   value = [ "${var.azs}" ]
}
