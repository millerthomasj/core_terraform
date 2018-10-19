resource "aws_db_subnet_group" "db_subnet_group" {	
  name_prefix = "${var.project}-${var.env}"
  subnet_ids  = ["${data.aws_subnet_ids.private_subnets.ids}"]	
	
  tags {	
    Terraform = true
    Project   = "${var.project}"
    Name      = "${var.project}-${var.env}"
  }
}
