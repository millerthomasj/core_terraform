data "aws_caller_identity" "current" {}

data "aws_ami" "bastion" {
  most_recent = true

  name_regex = "${var.env}-${var.project}-bastion*"

  owners = ["${data.aws_caller_identity.current.account_id}"]
}

data "template_file" "bastion_userdata" {
  template = "${file("templates/bastion.tpl")}"

  vars {
    name            = "bastion.${data.template_file.domain.rendered}"
    hostname_prefix = "${var.devphase["${var.env}"]}-${var.stack}-bastion"
    project         = "${var.project}"
    domain          = "${data.aws_route53_zone.public.name}"
  }
}

module "asg" {
  source                    = "git::https://stash.dev-charter.net/stash/scm/portals/terraform_modules.git//autoscaling"
  asg_name                  = "${var.env}-bastion"
  app_name                  = "bastion"
  app_name_long             = "${var.env}_${var.stack}_bastion"
  env                       = "${var.env}"
  dns_zone                  = "${data.template_file.domain.rendered}"
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 2
  subnets                   = ["${data.aws_subnet_ids.private_subnets.ids}"]
  image_id                  = "${data.aws_ami.bastion.id}"
  instance_type             = "${var.instance_type}"
  iam_instance_profile      = "SEservice"
  key_name                  = "deploy"
  security_groups           = [
      "${data.terraform_remote_state.security_groups.sg_ssh}",
      "${data.terraform_remote_state.security_groups.sg_monitoring}",
      "${data.terraform_remote_state.security_groups.sg_consul}"
  ]
  user_data                 = "${data.template_file.bastion_userdata.rendered}"
  load_balancers            = ["${aws_elb.bastion_elb.name}"]
  template_path             = "templates/bastion.tpl"
  protect_from_scale_in     = false
}

resource "aws_elb" "bastion_elb" {
  name = "${var.env}-bastion"

  security_groups           = ["${data.terraform_remote_state.security_groups.sg_ssh}"]
  subnets                   = ["${data.aws_subnet_ids.public_subnets.ids}"]
  internal                  = "${var.bastion_internal}"
  cross_zone_load_balancing = true
  idle_timeout              = 120

  listener {
    instance_port     = 22
    instance_protocol = "tcp"
    lb_port           = 22
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:22"
    interval            = 30
  }

  tags {
    Name        = "bastion.${data.template_file.domain.rendered}"
    Terraform   = true
    Project     = "${var.project}"
    Application = "bastion"
    creator     = "DL-SEDevOps-Portals@charter.com"
  }
}
