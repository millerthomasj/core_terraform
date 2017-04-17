## declare all the env-specific variables that are defined in *.tfvars

region = "us-west-2"
environment = "dev"
dns_zone = "dev-charter.net."

state_bucket_name = "eos.terraform.state"

# VPC ID may change as people destroy and recreate scratch VPC
vpc_id = "vpc-df1456b8"
availability_zones = [ "us-west-2b", "us-west-2c" ]
private_subnet_ids = [ "subnet-573bb20f", "subnet-5fe6983b" ]
private_subnet_cidrs = [ "10.3.16.0/20", "10.3.32.0/20" ]
public_subnet_ids = [ "subnet-8625acde", "subnet-31e89655" ]
public_subnet_cidrs = [ "10.3.0.0/22", "10.3.4.0/22" ]
