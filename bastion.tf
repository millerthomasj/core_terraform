data "template_file" "bastion_userdata" {
  template = "${file("templates/bastion.tpl")}"

  vars {
    name            = "bastion.portals.${var.environment}-spectrum.net"
    hostname_prefix = "bastion"
    domain          = ""
  }
}

resource "aws_launch_configuration" "bastion_lc" {
  name          = "bastion"
  image_id      = "ami-274bf658"
  instance_type = "c5.large"
  user_data     = "${data.template_file.bastion_userdata.rendered}"

  # iam_instance_profile = "${var.default_iam_profile}"
  # security_groups = [ "${concat(list(aws_security_group.ssh_traffic.id),list(aws_security_group.monitoring_traffic.id),list(aws_security_group.allow_internal.id),list(aws_security_group.portal_ops_ssh_traffic.id))}" ]

  lifecycle {
    create_before_destroy = true
  }
  key_name = "deploy"
}

resource "aws_autoscaling_group" "bastion_asg" {
  depends_on           = ["aws_launch_configuration.bastion_lc"]
  name                 = "bastion"
  launch_configuration = "${aws_launch_configuration.bastion_lc.name}"
  vpc_zone_identifier  = ["${data.aws_subnet_ids.private_subnets.ids}"]
  load_balancers       = ["${aws_elb.bastion_elb.name}"]
  min_size             = "1"
  max_size             = "1"
  desired_capacity     = "1"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "bastion_elb" {
  name = "bastion"

  # security_groups             = [ "${concat(list(aws_security_group.ssh_traffic.id),list(aws_security_group.portal_ops_ssh_traffic.id))}" ]
  subnets                   = ["${data.aws_subnet_ids.public_subnets.ids}"]
  internal                  = true
  cross_zone_load_balancing = true
  idle_timeout              = "120"

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
}
