resource "aws_ecs_task_definition" "consul" {
  family = "consul"
  network_mode = "host"
  container_definitions = "${data.template_file.consul_task.rendered}"

  volume {
    name = "consulconfig"
    host_path = "/var/consul/conf"
  }
}

resource "aws_ecs_service" "consul_server" {
  name = "${var.project}-consul-server"
  cluster = "${aws_ecs_cluster.autodiscovery.id}"
  iam_role = "${aws_iam_role.ecs_role.arn}"
  task_definition = "${aws_ecs_task_definition.consul.family}:${aws_ecs_task_definition.consul.revision}"
  desired_count = "${var.consul_servers_desired}"

  depends_on = ["aws_iam_role_policy.ecs_service_role_policy"]

  load_balancer {
    elb_name = "${aws_elb.consul.id}"
    container_name = "consul"
    container_port = 8500
  }

  deployment_minimum_healthy_percent = 50
}

resource "aws_elb" "consul" {
  name = "consul"
  security_groups = ["${aws_security_group.load_balancers.id}"]
  subnets = ["${var.zones}"]

  listener {
    lb_protocol = "http"
    lb_port = 80

     instance_protocol = "http"
     instance_port = 8500
  }

  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:8500/ui/"
    interval = 10
  }

  cross_zone_load_balancing = true
}
