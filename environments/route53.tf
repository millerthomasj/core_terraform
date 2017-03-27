resource "aws_route53_zone" "local_zone" {
  name = "${var.dns_zone}"
  comment = "Private Hosted Zone for ${var.project_name}"

  vpc_id = "${var.vpc_id}"
  force_destroy = true

  tags = {
    "Terraform"   = "true"
    "Environment" = "${var.environment}"
    "Project"     = "${var.project_name}"
  }
}
