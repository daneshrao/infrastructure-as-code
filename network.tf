  resource "aws_vpc" "terraformVPC" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = "true"

  }

  resource "aws_subnet" "terra_pub1" {
    cidr_block = "10.0.1.0/24"
    vpc_id = "${aws_vpc.terraformVPC.id}"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = "true"

  }

  resource "aws_subnet" "terra_pub2" {
    cidr_block = "10.0.2.0/24"
    vpc_id = "${aws_vpc.terraformVPC.id}"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = "true"

  }

  resource "aws_internet_gateway" "terra_igw" {
    vpc_id = "${aws_vpc.terraformVPC.id}"

  }

  resource "aws_route_table" "terra-RT" {
    vpc_id = "${aws_vpc.terraformVPC.id}"

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.terra_igw.id}"
    }
  }


  resource "aws_route_table_association" "Subnet-association" {
    subnet_id = ["${aws_subnet.terra_pub.id}", "${aws_subnet.terra_pub2.id}"]
    route_table_id = "${aws_route_table.terra-RT.id}"
  }

  resource "aws_security_group" "terra_secgrp" {
    vpc_id      = "${aws_vpc.terraformVPC.id}"
    ingress {
      description = "all traffic into vpc"
      from_port   = 0
      to_port     = 0
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-2"
      cidr_blocks = ["0.0.0.0/0"]
    }
    }
