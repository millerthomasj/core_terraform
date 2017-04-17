module "sg_web" {
  source = "github.com/terraform-community-modules/tf_aws_sg//sg_web"
  security_group_name = "${var.security_group_name}-web"
  vpc_id = "${module.vpc.vpc_id}"
  source_cidr_block = "${var.cidr}"
}
