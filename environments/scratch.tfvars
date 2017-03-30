## declare all the env-specific variables that are defined in *.tfvars

region = "us-west-1"
environment = "scratch"
dns_zone = "scratch-charter.net"

state_bucket_name = "eos-terraform-state"

# VPC ID may change as people destroy and recreate scratch VPC
vpc_id = "vpc-bc2488d8"
availability_zones = [ "us-west-1a", "us-west-1b" ]
private_subnet_ids = [ "subnet-573bb20f", "subnet-5fe6983b" ]
private_subnet_cidrs = [ "10.0.101.0/24", "10.0.102.0/24" ]
public_subnet_ids = [ "subnet-8625acde", "subnet-31e89655" ]
public_subnet_cidrs = [ "10.0.1.0/24", "10.0.2.0/24" ]
