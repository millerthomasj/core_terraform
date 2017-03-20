data "template_file" "consul_task" {
  template = "${file("${path.module}/task-definitions/consul.json")}"

  vars {
    consul_version = "${var.consul_version}"
    region = "${var.region}"
  }
}

data "template_file" "autodiscovery" {
  template = "${file("${path.module}/templates/cluster.tpl")}"

  vars {
    clustername = "${aws_ecs_cluster.autodiscovery.name}"
  }
}

data "template_file" "consulserver" {
  template = "${file("${path.module}/templates/consul.tpl")}"

  vars {
    clusterkey = "${var.uniquekey}"
    environment = "${var.environment}"
    config = "server"
    ui = "false"
    desired_count = "${var.consul_servers_desired}" 
  }
}

data "template_cloudinit_config" "autodiscovery_cloudinit" {
  gzip = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content = "${data.template_file.autodiscovery.rendered}"
  }

  part {
    content_type = "text/x-shellscript"
    content = "${data.template_file.consulserver.rendered}"
  }
}
