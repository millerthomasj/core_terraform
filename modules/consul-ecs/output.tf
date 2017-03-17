output "cluster" {
  value = "${aws_ecs_cluster.autodiscovery.id}"
}

output "dns_name" {
  value = "${aws_elb.consul.dns_name}"
}

output "port" {
  value = ["${aws_elb.consul.listener.*.lb_port[0]}"]
}
