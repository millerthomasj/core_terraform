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
    "${aws_security_group.docker_sg.id}"]

  iam_instance_profile = "${aws_iam_instance_profile.ecs_instance_profile.name}"

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
  vpc_zone_identifier = [ "${var.zones}" ]

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
#  # scaling policy
# Create task definition to start consul agent on every ECS node
# Create task definition to start registrator/nomad on every ECS node

data "template_file" "autodiscovery" {
  template = "${file("${path.module}/templates/cluster.tpl")}"

  vars {
    clustername = "${aws_ecs_cluster.autodiscovery.name}"
  }
}

data "template_file" "consulserver" {
  template = "${file("${path.module}/templates/consul.tpl")}"

  vars {
    clusterkey = "${var.uniquekey}"
    environment = "${var.environment}"
    config = "server"
    ui = "false"
  }
}

data "template_cloudinit_config" "autodiscovery_cloudinit" {
  gzip = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content = "${data.template_file.autodiscovery.rendered}"
  }

  part {
    content_type = "text/x-shellscript"
    content = "${data.template_file.consulserver.rendered}"
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
  name = "${var.project}-consul-server"
  cluster = "${aws_ecs_cluster.autodiscovery.id}"
  task_definition = "${aws_ecs_task_definition.consul.arn}"
  desired_count = "${var.consul_servers_desired}"
}
