resource "aws_elb" "scratch-elb" {
  name    = "scratch-elb"
  subnets = ["${var.private_subnets}","${var.public_subnets}"]
  security_groups = ["${module.sg_web.security_group_id_web}"]

  access_logs {
    bucket        = "com.scratch-charter.logs"
    interval      = 60
  }

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 8000
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:iam::422152100797:server-certificate/pci-scratch-charter.net-selfsigned"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

#  instances                   = ["${aws_instance.scratch-elb.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    "Name" = "scratch-elb"
    "Terraform" = "true"
    "Environment" = "${var.environment}"
  }
}
