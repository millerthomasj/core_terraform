environment = "scratch"
name = "EOS Scratch"

azs = [ "us-west-1a", "us-west-1b" ]
cidr = "10.0.0.0/16"

public_subnets = [ "10.0.1.0/24", "10.0.2.0/24" ]
private_subnets = [ "10.0.101.0/24", "10.0.102.0/24" ]

lc_name = "asg_test"
asg_ami_id = "ami-324e6b52"
asg_name = "scratch_asg"
asg_number_of_instances = 2
asg_minimum_number_of_instances = 1
elb_names = "scratch_elb"
health_check_type = "ELB"

security_group_name = "sg_scratch"
