module "consul-ecs" {
  source = "../modules/consul-ecs"

  project = "${var.group_name}"
  environment = "${var.environment}"
  region = "${var.region}"

  vpc = "${module.vpc.vpc_id}"
  public_subnets = "${var.public_subnets}"
  public_zones = "${module.vpc.public_subnets}"
  private_subnets = "${var.private_subnets}"
  private_zones = "${module.vpc.private_subnets}"

  consul_version = "${var.consul_version}"

  consul_servers_min = "${var.consul_servers_min}"
  consul_servers_max = "${var.consul_servers_max}"
  consul_servers_desired = "${var.consul_servers_desired}"

  uniquekey = "${var.consul_key}"

  allow_access = "${var.allow_vpn}"
}

#provider "consul" {
#   address = "${module.consul-ecs.dns_name}:80"
#   datacenter = "${var.region}"
#}
#
#resource "consul_key_prefix" "core_config" {
#  datacenter = "${var.region}"
#  
#  path_prefix = "core/"
#
#  subkeys = {
#    "public_subnets" = "${join(",", var.public_subnets)}"
#    "private_subnets" = "${join(",", var.private_subnets)}"
#  }
#
#  depends_on = ["module.consul-ecs"]
#}
