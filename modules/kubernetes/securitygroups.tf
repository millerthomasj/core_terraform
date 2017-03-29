resource "aws_security_group" "api-elb-eos-kubernetes-scratch-charter-net" {
  name        = "api-elb.eos-kubernetes.scratch-charter.net"
  vpc_id      = "vpc-bc2488d8"
  description = "Security group for api ELB"

  tags = {
    KubernetesCluster = "eos-kubernetes.scratch-charter.net"
    Name              = "api-elb.eos-kubernetes.scratch-charter.net"
  }
}

resource "aws_security_group" "bastion-elb-eos-kubernetes-scratch-charter-net" {
  name        = "bastion-elb.eos-kubernetes.scratch-charter.net"
  vpc_id      = "vpc-bc2488d8"
  description = "Security group for bastion ELB"

  tags = {
    KubernetesCluster = "eos-kubernetes.scratch-charter.net"
    Name              = "bastion-elb.eos-kubernetes.scratch-charter.net"
  }
}

resource "aws_security_group" "bastion-eos-kubernetes-scratch-charter-net" {
  name        = "bastion.eos-kubernetes.scratch-charter.net"
  vpc_id      = "vpc-bc2488d8"
  description = "Security group for bastion"

  tags = {
    KubernetesCluster = "eos-kubernetes.scratch-charter.net"
    Name              = "bastion.eos-kubernetes.scratch-charter.net"
  }
}

resource "aws_security_group" "masters-eos-kubernetes-scratch-charter-net" {
  name        = "masters.eos-kubernetes.scratch-charter.net"
  vpc_id      = "vpc-bc2488d8"
  description = "Security group for masters"

  tags = {
    KubernetesCluster = "eos-kubernetes.scratch-charter.net"
    Name              = "masters.eos-kubernetes.scratch-charter.net"
  }
}

resource "aws_security_group" "nodes-eos-kubernetes-scratch-charter-net" {
  name        = "nodes.eos-kubernetes.scratch-charter.net"
  vpc_id      = "vpc-bc2488d8"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster = "eos-kubernetes.scratch-charter.net"
    Name              = "nodes.eos-kubernetes.scratch-charter.net"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-eos-kubernetes-scratch-charter-net.id}"
  source_security_group_id = "${aws_security_group.masters-eos-kubernetes-scratch-charter-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-eos-kubernetes-scratch-charter-net.id}"
  source_security_group_id = "${aws_security_group.masters-eos-kubernetes-scratch-charter-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-eos-kubernetes-scratch-charter-net.id}"
  source_security_group_id = "${aws_security_group.nodes-eos-kubernetes-scratch-charter-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "api-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.api-elb-eos-kubernetes-scratch-charter-net.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.bastion-eos-kubernetes-scratch-charter-net.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.bastion-elb-eos-kubernetes-scratch-charter-net.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-to-master-ssh" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-eos-kubernetes-scratch-charter-net.id}"
  source_security_group_id = "${aws_security_group.bastion-eos-kubernetes-scratch-charter-net.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "bastion-to-node-ssh" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-eos-kubernetes-scratch-charter-net.id}"
  source_security_group_id = "${aws_security_group.bastion-eos-kubernetes-scratch-charter-net.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "https-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-eos-kubernetes-scratch-charter-net.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-elb-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-eos-kubernetes-scratch-charter-net.id}"
  source_security_group_id = "${aws_security_group.api-elb-eos-kubernetes-scratch-charter-net.id}"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-eos-kubernetes-scratch-charter-net.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-eos-kubernetes-scratch-charter-net.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-protocol-ipip" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-eos-kubernetes-scratch-charter-net.id}"
  source_security_group_id = "${aws_security_group.nodes-eos-kubernetes-scratch-charter-net.id}"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "4"
}

resource "aws_security_group_rule" "node-to-master-tcp-1-4001" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-eos-kubernetes-scratch-charter-net.id}"
  source_security_group_id = "${aws_security_group.nodes-eos-kubernetes-scratch-charter-net.id}"
  from_port                = 1
  to_port                  = 4001
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-eos-kubernetes-scratch-charter-net.id}"
  source_security_group_id = "${aws_security_group.nodes-eos-kubernetes-scratch-charter-net.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-eos-kubernetes-scratch-charter-net.id}"
  source_security_group_id = "${aws_security_group.nodes-eos-kubernetes-scratch-charter-net.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-elb-to-bastion" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.bastion-eos-kubernetes-scratch-charter-net.id}"
  source_security_group_id = "${aws_security_group.bastion-elb-eos-kubernetes-scratch-charter-net.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "ssh-external-to-bastion-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.bastion-elb-eos-kubernetes-scratch-charter-net.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
