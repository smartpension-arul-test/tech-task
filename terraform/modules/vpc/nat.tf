/*
  NAT Instance
*/
resource "aws_security_group" "nat" {
    name = "vpc_nat"
    description = "Allow traffic to pass from the private subnet to the internet"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = aws_vpc.smartpension_test.id

    tags = {
        Name = "NATSG"
    }
}

resource "aws_instance" "nat_1" {
    ami = "ami-30913f47" # this is a special ami preconfigured to do NAT
    availability_zone = var.region_1_az_1
    instance_type = "m1.small"
    key_name = var.aws_key_name
    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
    subnet_id = aws_subnet.smartpension_test_public_subnet_1.id
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = "VPC NAT"
    }
}

resource "aws_instance" "nat_2" {
    ami = "ami-30913f47" # this is a special ami preconfigured to do NAT
    availability_zone = var.region_1_az_2
    instance_type = "m1.small"
    key_name = var.aws_key_name
    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
    subnet_id = aws_subnet.smartpension_test_public_subnet_2.id
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = "VPC NAT"
    }
}

resource "aws_eip" "nat_1" {
    instance = aws_instance.nat_1.id
    vpc = true
}

resource "aws_eip" "nat_2" {
    instance = aws_instance.nat_2.id
    vpc = true
}







