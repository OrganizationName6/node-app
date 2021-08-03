provider "aws" {

}

resource "aws_vpc" "default" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
}

resource "aws_subnet" "public-subnet" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = var.subnet_cidr
  availability_zone = var.subnet_availability_zone

}

resource "aws_security_group" "sample_security_group" {
  name = "vpc_sample"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  vpc_id="${aws_vpc.default.id}"

}

resource "aws_instance" "ec2_master_instance" {
        count = var.master_instance_count
        ami = var.ec2_ami
        instance_type = var.master_instance_type
        subnet_id = "${aws_subnet.public-subnet.id}"
        vpc_security_group_ids = ["${aws_security_group.sample_security_group.id}"]
        key_name = var.pem_file_name
        tags = {
          Name = var.master_instance_name
        }
}

resource "aws_instance" "ec2_worker_instance" {
        count = var.worker_instance_count
        ami = var.ec2_ami
        instance_type = var.worker_instance_type
        subnet_id = "${aws_subnet.public-subnet.id}"
        vpc_security_group_ids = ["${aws_security_group.sample_security_group.id}"]
        key_name = var.pem_file_name
        tags = {
          Name = var.worker_instance_name
        }
}

