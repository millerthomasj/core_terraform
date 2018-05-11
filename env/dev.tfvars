environment = "dev"
region = "us-east-1"
vpc_id = "vpc-0532e5606ac66b8b8"
public_subnet_filter = "portals*elb*"
private_subnet_filter = "portals*app*"
bucket = "portals.terraform.dev"
bastion_internal = true
bastion_nat_ip = "69.76.31.11"

