output "cluster_name" {
  value = "kubernetes.scratch.eos.local"
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-kubernetes-scratch-eos-local.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-kubernetes-scratch-eos-local.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-west-1a-kubernetes-scratch-eos-local.id}"]
}

output "region" {
  value = "us-west-1"
}

output "vpc_id" {
  value = "${aws_vpc.kubernetes-scratch-eos-local.id}"
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_autoscaling_group" "master-us-west-1a-masters-kubernetes-scratch-eos-local" {
  name                 = "master-us-west-1a.masters.kubernetes.scratch.eos.local"
  launch_configuration = "${aws_launch_configuration.master-us-west-1a-masters-kubernetes-scratch-eos-local.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-west-1a-kubernetes-scratch-eos-local.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kubernetes.scratch.eos.local"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-west-1a.masters.kubernetes.scratch.eos.local"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "nodes-kubernetes-scratch-eos-local" {
  name                 = "nodes.kubernetes.scratch.eos.local"
  launch_configuration = "${aws_launch_configuration.nodes-kubernetes-scratch-eos-local.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-west-1a-kubernetes-scratch-eos-local.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kubernetes.scratch.eos.local"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.kubernetes.scratch.eos.local"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }
}

resource "aws_ebs_volume" "a-etcd-events-kubernetes-scratch-eos-local" {
  availability_zone = "us-west-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster    = "kubernetes.scratch.eos.local"
    Name                 = "a.etcd-events.kubernetes.scratch.eos.local"
    "k8s.io/etcd/events" = "a/a"
    "k8s.io/role/master" = "1"
  }
}

resource "aws_ebs_volume" "a-etcd-main-kubernetes-scratch-eos-local" {
  availability_zone = "us-west-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster    = "kubernetes.scratch.eos.local"
    Name                 = "a.etcd-main.kubernetes.scratch.eos.local"
    "k8s.io/etcd/main"   = "a/a"
    "k8s.io/role/master" = "1"
  }
}

resource "aws_iam_instance_profile" "masters-kubernetes-scratch-eos-local" {
  name  = "masters.kubernetes.scratch.eos.local"
  roles = ["${aws_iam_role.masters-kubernetes-scratch-eos-local.name}"]
}

resource "aws_iam_instance_profile" "nodes-kubernetes-scratch-eos-local" {
  name  = "nodes.kubernetes.scratch.eos.local"
  roles = ["${aws_iam_role.nodes-kubernetes-scratch-eos-local.name}"]
}

resource "aws_iam_role" "masters-kubernetes-scratch-eos-local" {
  name               = "masters.kubernetes.scratch.eos.local"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.kubernetes.scratch.eos.local_policy")}"
}

resource "aws_iam_role" "nodes-kubernetes-scratch-eos-local" {
  name               = "nodes.kubernetes.scratch.eos.local"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.kubernetes.scratch.eos.local_policy")}"
}

resource "aws_iam_role_policy" "masters-kubernetes-scratch-eos-local" {
  name   = "masters.kubernetes.scratch.eos.local"
  role   = "${aws_iam_role.masters-kubernetes-scratch-eos-local.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.kubernetes.scratch.eos.local_policy")}"
}

resource "aws_iam_role_policy" "nodes-kubernetes-scratch-eos-local" {
  name   = "nodes.kubernetes.scratch.eos.local"
  role   = "${aws_iam_role.nodes-kubernetes-scratch-eos-local.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.kubernetes.scratch.eos.local_policy")}"
}

resource "aws_internet_gateway" "kubernetes-scratch-eos-local" {
  vpc_id = "${aws_vpc.kubernetes-scratch-eos-local.id}"

  tags = {
    KubernetesCluster = "kubernetes.scratch.eos.local"
    Name              = "kubernetes.scratch.eos.local"
  }
}

resource "aws_key_pair" "kubernetes-kubernetes-scratch-eos-local-ff96daf227cd61f914325157b5ea136f" {
  key_name   = "kubernetes.kubernetes.scratch.eos.local-ff:96:da:f2:27:cd:61:f9:14:32:51:57:b5:ea:13:6f"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.kubernetes.scratch.eos.local-ff96daf227cd61f914325157b5ea136f_public_key")}"
}

resource "aws_launch_configuration" "master-us-west-1a-masters-kubernetes-scratch-eos-local" {
  name_prefix                 = "master-us-west-1a.masters.kubernetes.scratch.eos.local-"
  image_id                    = "ami-bceebedc"
  instance_type               = "m3.medium"
  key_name                    = "${aws_key_pair.kubernetes-kubernetes-scratch-eos-local-ff96daf227cd61f914325157b5ea136f.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-kubernetes-scratch-eos-local.id}"
  security_groups             = ["${aws_security_group.masters-kubernetes-scratch-eos-local.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-west-1a.masters.kubernetes.scratch.eos.local_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 20
    delete_on_termination = true
  }

  ephemeral_block_device = {
    device_name  = "/dev/sdc"
    virtual_name = "ephemeral0"
  }

  lifecycle = {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "nodes-kubernetes-scratch-eos-local" {
  name_prefix                 = "nodes.kubernetes.scratch.eos.local-"
  image_id                    = "ami-bceebedc"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-kubernetes-scratch-eos-local-ff96daf227cd61f914325157b5ea136f.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-kubernetes-scratch-eos-local.id}"
  security_groups             = ["${aws_security_group.nodes-kubernetes-scratch-eos-local.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.kubernetes.scratch.eos.local_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 20
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.kubernetes-scratch-eos-local.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.kubernetes-scratch-eos-local.id}"
}

resource "aws_route_table" "kubernetes-scratch-eos-local" {
  vpc_id = "${aws_vpc.kubernetes-scratch-eos-local.id}"

  tags = {
    KubernetesCluster = "kubernetes.scratch.eos.local"
    Name              = "kubernetes.scratch.eos.local"
  }
}

resource "aws_route_table_association" "us-west-1a-kubernetes-scratch-eos-local" {
  subnet_id      = "${aws_subnet.us-west-1a-kubernetes-scratch-eos-local.id}"
  route_table_id = "${aws_route_table.kubernetes-scratch-eos-local.id}"
}

resource "aws_security_group" "masters-kubernetes-scratch-eos-local" {
  name        = "masters.kubernetes.scratch.eos.local"
  vpc_id      = "${aws_vpc.kubernetes-scratch-eos-local.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster = "kubernetes.scratch.eos.local"
    Name              = "masters.kubernetes.scratch.eos.local"
  }
}

resource "aws_security_group" "nodes-kubernetes-scratch-eos-local" {
  name        = "nodes.kubernetes.scratch.eos.local"
  vpc_id      = "${aws_vpc.kubernetes-scratch-eos-local.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster = "kubernetes.scratch.eos.local"
    Name              = "nodes.kubernetes.scratch.eos.local"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetes-scratch-eos-local.id}"
  source_security_group_id = "${aws_security_group.masters-kubernetes-scratch-eos-local.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-kubernetes-scratch-eos-local.id}"
  source_security_group_id = "${aws_security_group.masters-kubernetes-scratch-eos-local.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-kubernetes-scratch-eos-local.id}"
  source_security_group_id = "${aws_security_group.nodes-kubernetes-scratch-eos-local.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-kubernetes-scratch-eos-local.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-kubernetes-scratch-eos-local.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-kubernetes-scratch-eos-local.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetes-scratch-eos-local.id}"
  source_security_group_id = "${aws_security_group.nodes-kubernetes-scratch-eos-local.id}"
  from_port                = 1
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetes-scratch-eos-local.id}"
  source_security_group_id = "${aws_security_group.nodes-kubernetes-scratch-eos-local.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetes-scratch-eos-local.id}"
  source_security_group_id = "${aws_security_group.nodes-kubernetes-scratch-eos-local.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-kubernetes-scratch-eos-local.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-kubernetes-scratch-eos-local.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-west-1a-kubernetes-scratch-eos-local" {
  vpc_id            = "${aws_vpc.kubernetes-scratch-eos-local.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-west-1a"

  tags = {
    KubernetesCluster = "kubernetes.scratch.eos.local"
    Name              = "us-west-1a.kubernetes.scratch.eos.local"
  }
}

resource "aws_vpc" "kubernetes-scratch-eos-local" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster = "kubernetes.scratch.eos.local"
    Name              = "kubernetes.scratch.eos.local"
  }
}

resource "aws_vpc_dhcp_options" "kubernetes-scratch-eos-local" {
  domain_name         = "us-west-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster = "kubernetes.scratch.eos.local"
    Name              = "kubernetes.scratch.eos.local"
  }
}

resource "aws_vpc_dhcp_options_association" "kubernetes-scratch-eos-local" {
  vpc_id          = "${aws_vpc.kubernetes-scratch-eos-local.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.kubernetes-scratch-eos-local.id}"
}
