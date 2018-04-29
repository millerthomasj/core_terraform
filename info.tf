data "aws_subnet_ids" "private_subnets" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "portals-private*"
  }
}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "portals-elb*"
  }
}
