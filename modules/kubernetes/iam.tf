resource "aws_iam_instance_profile" "bastions-eos-kubernetes-scratch-charter-net" {
  name  = "bastions.eos-kubernetes.scratch-charter.net"
  roles = ["${aws_iam_role.bastions-eos-kubernetes-scratch-charter-net.name}"]
}

resource "aws_iam_instance_profile" "masters-eos-kubernetes-scratch-charter-net" {
  name  = "masters.eos-kubernetes.scratch-charter.net"
  roles = ["${aws_iam_role.masters-eos-kubernetes-scratch-charter-net.name}"]
}

resource "aws_iam_instance_profile" "nodes-eos-kubernetes-scratch-charter-net" {
  name  = "nodes.eos-kubernetes.scratch-charter.net"
  roles = ["${aws_iam_role.nodes-eos-kubernetes-scratch-charter-net.name}"]
}

resource "aws_iam_role" "bastions-eos-kubernetes-scratch-charter-net" {
  name               = "bastions.eos-kubernetes.scratch-charter.net"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_bastions.eos-kubernetes.scratch-charter.net_policy")}"
}

resource "aws_iam_role" "masters-eos-kubernetes-scratch-charter-net" {
  name               = "masters.eos-kubernetes.scratch-charter.net"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.eos-kubernetes.scratch-charter.net_policy")}"
}

resource "aws_iam_role" "nodes-eos-kubernetes-scratch-charter-net" {
  name               = "nodes.eos-kubernetes.scratch-charter.net"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.eos-kubernetes.scratch-charter.net_policy")}"
}

resource "aws_iam_role_policy" "bastions-eos-kubernetes-scratch-charter-net" {
  name   = "bastions.eos-kubernetes.scratch-charter.net"
  role   = "${aws_iam_role.bastions-eos-kubernetes-scratch-charter-net.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_bastions.eos-kubernetes.scratch-charter.net_policy")}"
}

resource "aws_iam_role_policy" "masters-eos-kubernetes-scratch-charter-net" {
  name   = "masters.eos-kubernetes.scratch-charter.net"
  role   = "${aws_iam_role.masters-eos-kubernetes-scratch-charter-net.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.eos-kubernetes.scratch-charter.net_policy")}"
}

resource "aws_iam_role_policy" "nodes-eos-kubernetes-scratch-charter-net" {
  name   = "nodes.eos-kubernetes.scratch-charter.net"
  role   = "${aws_iam_role.nodes-eos-kubernetes-scratch-charter-net.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.eos-kubernetes.scratch-charter.net_policy")}"
}
