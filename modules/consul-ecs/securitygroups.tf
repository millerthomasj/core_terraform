resource "aws_security_group" "consul_sg" {
  name = "consul-discovery-sg"
  description = "Security group for the EC2 instances of the Discovery ECS cluster"
  vpc_id = "${var.vpc}"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 8300
    to_port = 8302
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 8300
    to_port = 8302
    protocol = "udp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 8400
    to_port = 8400
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 8500
    to_port = 8500
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 8600
    to_port = 8600
    protocol = "udp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags {
    "Terraform" = "true"
    "Environment" = "${var.environment}"
  }
}

# I believe this should be bubbled up and have the private subnets allowed to access
resource "aws_security_group" "docker_sg" {
  name = "docker-sg"
  description = "Security group for the EC2 instances to access docker"
  vpc_id = "${var.vpc}"

  ingress {
    from_port = 32768
    to_port = 61000
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags {
    "Terraform" = "true"
    "Environment" = "${var.environment}"
  }
}

resource "aws_security_group" "consul" {
  name        = "consul-sg"
  description = "Consul internal traffic + maintenance."
  vpc_id      = "${var.vpc}"

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "udp"
    self      = true
  }

  // allow traffic for TCP 53 (DNS)
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow traffic for UDP 53 (DNS)
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow traffic for TCP 8300 (Server RPC)
  ingress {
    from_port   = 8300
    to_port     = 8300
    protocol    = "tcp"
    cidr_blocks = "${var.private_subnets}"
  }

  // allow traffic for TCP 8301 (Serf LAN)
  ingress {
    from_port   = 8301
    to_port     = 8301
    protocol    = "tcp"
    cidr_blocks = "${var.private_subnets}"
  }

  // allow traffic for UDP 8301 (Serf LAN)
  ingress {
    from_port   = 8301
    to_port     = 8301
    protocol    = "udp"
    cidr_blocks = "${var.private_subnets}"
  }

  // allow traffic for TCP 8400 (Consul RPC)
  ingress {
    from_port   = 8400
    to_port     = 8400
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow traffic for TCP 8500 (Consul Web UI)
  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    "Terraform" = "true"
    "Environment" = "${var.environment}"
  }
}

