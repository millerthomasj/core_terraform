module "asg_elb" {
  source = "github.com/terraform-community-modules/tf_aws_asg_elb"
  lc_name = "${var.lc_name}"
  ami_id = "${var.asg_ami_id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name = "${var.key_name}"
  security_group = "${module.sg_web.security_group_id_web}"
  user_data = "${var.user_data}"

  asg_name = "${var.asg_name}"
  asg_number_of_instances = "${var.asg_number_of_instances}"
  asg_minimum_number_of_instances = "${var.asg_minimum_number_of_instances}"

  load_balancer_names = "${var.elb_names}"

  // The health_check_type can be EC2 or ELB and defaults to ELB
  health_check_type = "${var.health_check_type}"
  health_check_grace_period = "${var.health_check_grace_period}"

  availability_zones = "${join(",", var.azs)}"
  vpc_zone_subnets = "${join(",", var.private_subnets)}"
}
