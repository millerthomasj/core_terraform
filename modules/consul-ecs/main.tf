resource "aws_ecs_cluster" "consul" {
  name = "consul-discovery"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "consul" {
  name_prefix = "consul-launch-"
  image_id = "${lookup(var.ami, var.region)}"
  instance_type = "${var.instance_type}"
  key_name = "${var.keypair}"
  // probably needs a default security group for either SSH bastion access or openvpn access
  security_groups = [
    "${aws_security_group.consul_sg.id}",
    "${aws_security_group.docker_sg.id}"]

  iam_instance_profile = "${aws_iam_instance_profile.consul_profile.name}"

  root_block_device {
    volume_type = "gp2"
    volume_size = 10
  }

  ebs_block_device {
    device_name = "/dev/xvdcz"
    volume_size = 22
    volume_type = "gp2"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "consul" {
  name = "consul-autoscaling"
  availability_zones = "${var.azs}"
  launch_configuration = "${aws_launch_configuration.consul.name}"
  desired_capacity = 1
  min_size = 1
  max_size = 1

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_task_definition" "consul" {
  family = "consul"

  network_mode = "host"

  container_definitions = <<EOF
[
  {
    "name": "consul",
    "image": "consul:0.7.5",
    "essential": true,
    "memory": 256,
    "memoryReservation": 128,
    "command": [ "consul", "agent", "-config-file=/consul/config/consul.conf" ],
    "portMappings": [
      {
        "containerPort": 8300,
        "hostPort": 8300,
        "protocol": "tcp"
      },
      {
        "containerPort": 8301,
        "hostPort": 8301,
        "protocol": "tcp"
      },
      {
        "containerPort": 8302,
        "hostPort": 8302,
        "protocol": "tcp"
      },
      {
        "containerPort": 8301,
        "hostPort": 8301,
        "protocol": "udp"
      },
      {
        "containerPort": 8302,
        "hostPort": 8302,
        "protocol": "udp"
      },
      {
        "containerPort": 8400,
        "hostPort": 8400,
        "protocol": "tcp"
      },
      {
        "containerPort": 8500,
        "hostPort": 8500,
        "protocol": "tcp"
      },
      {
        "containerPort": 8600,
        "hostPort": 8600,
        "protocol": "udp"
      }
    ],
    "mountPoints": [
      {
        "sourceVolume": "consulconfig",
        "containerPath": "/consul/config"
      }
    ],
    "environment": [
      { "name": "AWS_REGION", "value": "${var.region}" }
    ]
  }
]
EOF

  volume {
    name = "consulconfig"
    host_path = "/var/consul/conf"
  }

}

resource "aws_ecs_service" "consul_server" {
  name = "consul-server"
  cluster = "${aws_ecs_cluster.consul.id}"
  task_definition = "${aws_ecs_task_definition.consul.arn}"
  desired_count = "1"
}
