resource "aws_route53_zone" "local_zone" {
  name = "${var.environment}.${var.local_domain}"
  comment = "Private Hosted Zone for ${var.name}"

  vpc_id = "${module.vpc.vpc_id}"
  force_destroy = true

  tags = {
    "Terraform" = "true"
    "Environment" = "${var.environment}"
  }
}
