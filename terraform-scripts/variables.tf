variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "subnet_availability_zone" {
  type    = string
  default = "ap-south-1a"
}

variable "master_instance_count" {
  type    = number
  default = 1
}

variable "worker_instance_count" {
  type    = number
  default = 2
}

variable "ec2_ami" {
  type    = string
  default = "ami-0c1a7f89451184c8b"
}

variable "master_instance_type" {
  type    = string
  default = "t2.medium"
}

variable "worker_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "pem_file_name" {
  type    = string
  default = "mumbailaptop2"
}

variable "master_instance_name" {
  type    = string
  default = "Terraform-K8-Master-Server"
}

variable "worker_instance_name" {
  type    = string
  default = "Terraform-K8-Worker-Server"
}

