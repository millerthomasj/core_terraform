terraform {
  backend "s3" {
    key    = "core/core.tfstate"
  }
}

provider "aws" {
  region     = "${var.region}"
  profile    = "${var.environment}"
}

provider "kubernetes" {
  config_path            = "~/.kube/config-${var.environment}"
  config_context_cluster = "kubernetes.${aws_route53_record.local_ns.fqdn}"
}
