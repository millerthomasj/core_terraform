data "aws_ami" "amazonlinux" {
  most_recent = true

  owners = ["137112412989"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }
}

data "template_file" "bastion_userdata" {
  template = "${file("templates/bastion.tpl")}"

  vars {
    name            = "bastion.${data.template_file.domain.rendered}"
    hostname_prefix = "${var.devphase["${var.env}"]}-${var.stack}-bastion"
    project         = "${var.project_name}"
    domain          = "${data.aws_route53_zone.public.name}"
  }
}

resource "aws_launch_configuration" "bastion_lc" {
  name_prefix   = "bastion-${var.devphase["${var.env}"]}-"
  image_id      = "${data.aws_ami.amazonlinux.id}"
  instance_type = "${var.instance_type}"
  user_data     = "${data.template_file.bastion_userdata.rendered}"

  iam_instance_profile = "deploy"
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
  depends_on           = ["aws_launch_configuration.bastion_lc"]
  name_prefix          = "bastion-${var.devphase["${var.env}"]}"
  launch_configuration = "${aws_launch_configuration.bastion_lc.name}"
  vpc_zone_identifier  = ["${data.aws_subnet_ids.private_subnets.ids}"]
  load_balancers       = ["${aws_elb.bastion_elb.name}"]
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "bastion.${data.template_file.domain.rendered}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = true
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "${var.project_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Application"
    value               = "devops"
    propagate_at_launch = true
  }
}

resource "aws_elb" "bastion_elb" {
  name = "bastion-${var.devphase["${var.env}"]}"

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
    Project     = "${var.project_name}"
    Application = "devops"
  }
}
