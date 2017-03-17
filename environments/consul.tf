module "consul-ecs" {
  source = "../modules/consul-ecs"

  project = "${var.group_name}"
  environment = "${var.environment}"
  region = "${var.region}"

  vpc = "${module.vpc.vpc_id}"
  private_subnets = "${var.public_subnets}"
  zones = "${module.vpc.public_subnets}"

  consul_version = "${var.consul_version}"

  consul_servers_min = "${var.consul_servers_min}"
  consul_servers_max = "${var.consul_servers_max}"
  consul_servers_desired = "${var.consul_servers_desired}"

  uniquekey = "${var.consul_key}"
}
