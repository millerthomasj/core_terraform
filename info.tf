data "aws_subnet_ids" "private_subnets" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.private_subnet_filter}"
  }
}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.public_subnet_filter}"
  }
}

data "aws_security_group" "ssh_pa" {
  name = "portals_${var.environment}_ssh_pa"
}


data "aws_security_group" "ssh_elb" {
  name = "portals_${var.environment}_ssh_elb"
}

data "aws_security_group" "ssh_bastion" {
  name = "portals_${var.environment}_ssh_bastion"
}
