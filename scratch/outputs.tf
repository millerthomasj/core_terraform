output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "dns_zone" {
  value = "eos.scratch-charter.net"
}

output "availability_zones" {
  value = "${join(",", var.azs)}"
}

output "k8s_master_zone" {
  value = "${element(var.azs, 0)}"
}

output "k8s_state_store" {
  value = "s3://${var.state_bucket_name}/${var.k8s_state_path}"
}

output "k8s_version" {
  value = "${var.k8s_version}"
}

output "k8s_cluster_name" {
  value = "${var.k8s_cluster_name}.eos.scratch-charter.net"
}

output "k8s_master_size" {
  value = "${var.k8s_master_size}"
}

output "k8s_node_size" {
  value = "${var.k8s_node_size}"
}

output "k8s_node_count" {
  value = "${var.k8s_node_count}"
}
