data "aws_subnet_ids" "private_subnets" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.public_subnet_filter}"
  }
}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.private_subnet_filter}"
  }
}
