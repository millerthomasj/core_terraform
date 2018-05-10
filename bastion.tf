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
    name            = "bastion.portals.${var.environment}-spectrum.net"
    hostname_prefix = "${var.devphase["${var.environment}"]}-${var.stack["${var.environment}"]}-bastion"
    domain          = "${data.aws_route53_zone.public.name}"
  }
}

resource "aws_launch_configuration" "bastion_lc" {
  name          = "bastion"
  image_id      = "${data.aws_ami.amazonlinux.id}"
  instance_type = "m5.large"
  user_data     = "${data.template_file.bastion_userdata.rendered}"

  iam_instance_profile = "deploy"
  security_groups = [ "sg-05ac9620d20a6f965" ]
  key_name = "deploy"

  lifecycle {
    create_before_destroy = true
  }
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

  tag {
    key                 = "Name"
    value               = "bastion.portals.${var.environment}-spectrum.net"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = true
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "portals"
    propagate_at_launch = true
  }

  tag {
    key                 = "Application"
    value               = "devops"
    propagate_at_launch = true
  }
}

resource "aws_elb" "bastion_elb" {
  name = "bastion"

  security_groups             = [ "sg-05ac9620d20a6f965" ]
  subnets                   = ["${data.aws_subnet_ids.public_subnets.ids}"]
  internal                  = "${var.bastion_internal}"
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

  tags {                 
    Name = "bastion.portals.${var.environment}-spectrum.net"
    Terraform = true
    Project = "portals"
    Application = "devops"
  }
}
