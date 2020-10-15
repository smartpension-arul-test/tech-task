resource "aws_vpc" "smartpension_test" {
  tags = {
    Project = var.project_name
    Name    = "${var.project_name} VPC"
  }
  
  cidr_block = var.vpc_cidr
  
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

resource "aws_db_subnet_group" "smartpension_test_db_subnet" {
  name        = "smartpension_test_db_subnet"
  description = "db subnet group"
  subnet_ids  = ["${aws_subnet.smartpension_test_private_subnet_az_1.id}", "${aws_subnet.smartpension_test_private_subnet_az_2.id}"]

  tags = {
    Project = var.project_name
    Name    = "DB subnet group"
  }
}

# Private
resource "aws_subnet" "smartpension_test_private_subnet_az_1" {
  availability_zone = var.az_1

  cidr_block = var.private_subnet_az_1_cidr
  vpc_id     = aws_vpc.smartpension_test.id

  tags = {
    Project = "smartpension-test"
    Name    = "private ${var.az_1} subnet"
  }
}

resource "aws_subnet" "smartpension_test_private_subnet_az_2" {
  availability_zone = var.az_2

  cidr_block = var.private_subnet_az_2_cidr
  vpc_id     = aws_vpc.smartpension_test.id

  tags = {
    Project = "smartpension-test"
    Name    = "private ${var.az_2} subnet"
  }
}

# Public
resource "aws_subnet" "smartpension_test_public_subnet_az_1" {
  availability_zone = var.az_1

  cidr_block = var.public_subnet_az_1_cidr
  vpc_id     = aws_vpc.smartpension_test.id

  tags = {
    Project = "smartpension-test"
    Name    = "public ${var.az_1} subnet"
  }
}

resource "aws_subnet" "smartpension_test_public_subnet_az_2" {
  availability_zone = var.az_2

  cidr_block = var.public_subnet_az_2_cidr
  vpc_id     = aws_vpc.smartpension_test.id

  tags = {
    Project = "smartpension-test"
    Name    = "public ${var.az_2} subnet"
  }
}

resource "aws_internet_gateway" "smartpension_test" {
  vpc_id = aws_vpc.smartpension_test.id

  tags = {
    Name    = "smartpension-test internet-gateway"
    Project = "smartpension-test"
  }
}


