environment = "dev"
region = "us-east-1"
vpc_id = "vpc-0532e5606ac66b8b8"
public_subnet_filter = "portals*app*"
private_subnet_filter = "portals*elb*"

sgs_bucket_name = "com.charter.portal-dev.tfstate"
bastion_internal = true
bastion_nat_ip = "69.76.31.11"

