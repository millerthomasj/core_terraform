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

resource "aws_launch_configuration" "bastion_lc" {
  name_prefix   = "${var.env}-bastion-"
  image_id      = "${data.aws_ami.bastion.id}"
  instance_type = "${var.instance_type}"
  user_data     = "${data.template_file.bastion_userdata.rendered}"

  iam_instance_profile = "SEservice"
  security_groups      = [
      "${data.terraform_remote_state.security_groups.sg_ssh}",
      "${data.terraform_remote_state.security_groups.sg_monitoring}",
      "${data.terraform_remote_state.security_groups.sg_consul}"
  ]
  key_name             = "deploy"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bastion_asg" {
  name                 = "${var.env}-bastion"
  launch_configuration = "${aws_launch_configuration.bastion_lc.name}"
  vpc_zone_identifier  = ["${data.aws_subnet_ids.private_subnets.ids}"]
  load_balancers       = ["${aws_elb.bastion_elb.name}"]
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1

  lifecycle {
    create_before_destroy = true
  }

  tags = [
    "${concat(
         list(
           map("key", "Terraform", "value", true, "propagate_at_launch", true),
           map("key", "Name", "value", "bastion.${data.template_file.domain.rendered}", "propagate_at_launch", true),
           map("key", "Project", "value", "${var.project}", "propagate_at_launch", true),
           map("key", "Application", "value", "devops", "propagate_at_launch", true),
           map("key", "Environment", "value", "${var.env}", "propagate_at_launch", true),
           map("key", "creator", "value", "${var.dl_name}", "propagate_at_launch", true)
         )
       )
    }",
  ]
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
    Application = "devops"
  }
}
