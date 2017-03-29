output "vpc_id" {
  value = "${var.vpc_id}"
}

output "dns_zone" {
  value = "${aws_route53_record.local_ns.fqdn}"
}

output "availability_zones" {
  value = "${join(",", var.availability_zones)}"
}

output "k8s_master_zone" {
  value = "${element(var.availability_zones, 0)}"
}

output "k8s_state_store" {
  value = "s3://${var.state_bucket_name}/${var.k8s_state_path}"
}

output "k8s_version" {
  value = "${var.k8s_version}"
}

output "k8s_cluster_name" {
  value = "${var.k8s_cluster_name}.${aws_route53_record.local_ns.fqdn}"
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

