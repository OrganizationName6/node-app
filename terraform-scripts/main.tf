provider "aws" {

}

module "aws-s3" {
  source = "./modules/s3"
}

resource "aws_dynamodb_table" "terraform_locks" {
  hash_key = "LockID"
  name = "terraform-test-locks"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket = "nodejs-app-bucket"
    key = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-test-locks"
    encrypt = true
  }
}

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "public-subnet" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

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

resource "aws_instance" "aws_ec2_instance" {
        ami = "ami-0c1a7f89451184c8b"
        instance_type = "t2.micro"
        subnet_id = "${aws_subnet.public-subnet.id}"
        vpc_security_group_ids = ["${aws_security_group.sample_security_group.id}"]
        key_name = "mumbailaptop2"
        tags = {
          Name = "Ubuntu Server by Terraform"
        }
}
