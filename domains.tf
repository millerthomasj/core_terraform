data "template_file" "domain_prod" {
  template = "$${project}.spectrum.net"

  vars {
    project = "${var.project_name}"
  }
}

data "template_file" "domain_nonprod" {
  template = "$${project}.$${env}-spectrum.net"

  vars {
    project = "${var.project_name}"
    env     = "${var.env}"
  }
}

data "template_file" "domain" {
  template = "$${domain}"

  vars {
    domain = "${var.env == "prod" ? data.template_file.domain_prod.rendered : data.template_file.domain_nonprod.rendered}"
  }
}

data "template_file" "domain_local" {
  template = "$${project}.$${env}.local"

  vars {
    project = "${var.project_name}"
    env     = "${var.env}"
  }
}
