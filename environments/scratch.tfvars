environment = "scratch"
name = "EOS Scratch"

azs = [ "us-west-1a", "us-west-1b" ]
cidr = "10.0.0.0/16"
instance_type = ""

public_subnets = [ "10.0.1.0/24", "10.0.2.0/24" ]
private_subnets = [ "10.0.101.0/24", "10.0.102.0/24" ]

consul_version = "0.7.1"

# Only build one consul server (non-prod)
consul_servers_min = 3
consul_servers_max = 5
consul_servers_desired = 3

consul_key = "jzR9JcASngxMt7scCU57WrrTVUbYpV"
