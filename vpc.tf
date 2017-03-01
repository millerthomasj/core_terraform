provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

#Define the main vpc
resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr_block}"
    instance_tenancy= "dedicated"
    enable_dns_hostnames = true
    tags {
      Name = "${var.vpc_name}"}
}

#Create subnets

resource "aws_subnet" "subnet_pub" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.public_cidr_block}"
    availability_zone = "${var.availability_zone}"

    tags {
      Name = "${var.public_subnet_name}"
    }
}

resource "aws_subnet" "subnet_priv" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.private_cidr_block}"
    availability_zone = "${var.availability_zone}"

    tags {
      Name = "${var.private_subnet_name}"
    }
}

#Create NAT instance
#resource "aws_instance" "nat" {
#    ami = "${var.nat_ami}" # this is a special ami preconfigured to do NAT
#    availability_zone = "${var.availability_zone}"
#    instance_type = "${var.nat_type}"
#    key_name = "${var.aws_key_name}"
#    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
#    subnet_id = "${aws_subnet.subnet_pub.id}"
#    associate_public_ip_address = true
#    source_dest_check = false
#
#    tags {
#        Name = "VPC NAT"
#    }
