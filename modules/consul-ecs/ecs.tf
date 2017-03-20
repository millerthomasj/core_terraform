# Create the ECS cluster for consul
resource "aws_ecs_cluster" "autodiscovery" {
  name = "${var.project}-autodiscovery"

  lifecycle {
    create_before_destroy = true
  }
}

# Create Consul server group (which will also be on ECS node(s)

#  # Create launch configuration
resource "aws_launch_configuration" "consul_server" {
  name_prefix = "${var.project}-consul-server-"
  image_id = "${lookup(var.ami, var.region)}"
  instance_type = "${var.instance_type}"
  key_name = "${var.keypair}"
  // probably needs a default security group for either SSH bastion access or openvpn access
  security_groups = [
    "${aws_security_group.consul_sg.id}",
    "${aws_security_group.ecs.id}"]

  iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

  user_data = "${data.template_cloudinit_config.autodiscovery_cloudinit.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

#  # Create autoscaling group
resource "aws_autoscaling_group" "consul_server" {
  name = "${var.project}-consul-servers"
  launch_configuration = "${aws_launch_configuration.consul_server.name}"
  desired_capacity = "${var.consul_servers_desired}"
  min_size = "${var.consul_servers_min}"
  max_size = "${var.consul_servers_max}"
  vpc_zone_identifier = [ "${var.private_zones}" ]
  termination_policies = ["OldestLaunchConfiguration"]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key = "Name"
    value = "${var.project}-discovery"
    propagate_at_launch = true
  }

  tag {
    key = "autodiscovery-key"
    value = "${var.uniquekey}"
    propagate_at_launch = true
  }
}
