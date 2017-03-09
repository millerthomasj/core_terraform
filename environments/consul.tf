module "consul-ecs" {
  source = "../modules/consul-ecs"

  environment = "${var.environment}"
  region = "${var.region}"

  vpc = "${module.vpc.vpc_id}"
  private_subnets = "${var.private_subnets}"
  azs = "${var.azs}"
}
