output "bastion_security_group_ids" {
  value = ["${aws_security_group.bastion-eos-kubernetes-scratch-charter-net.id}"]
}

output "cluster_name" {
  value = "eos-kubernetes.scratch-charter.net"
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-eos-kubernetes-scratch-charter-net.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-eos-kubernetes-scratch-charter-net.id}"]
}

output "node_subnet_ids" {
  value = ["subnet-36e09e52", "subnet-d238b18a"]
}

output "region" {
  value = "us-west-1"
}

output "subnet_ids" {
  value = ["subnet-36e09e52", "subnet-46e29c22", "subnet-b13bb2e9", "subnet-d238b18a"]
}

output "vpc_id" {
  value = "vpc-bc2488d8"
}
