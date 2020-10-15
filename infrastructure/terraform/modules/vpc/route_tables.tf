resource "aws_route_table" "private_subnet_az_1_route_table" {
  vpc_id = aws_vpc.smartpension_test.id

  route {
        cidr_block = "0.0.0.0/0"
        instance_id = aws_instance.nat.id
    }

  tags = {
    Name    = "smartpension-test private subnet az1 route table"
    Project = "smartpension-test"
  }
}

resource "aws_route_table_association" "private_subnet_az_1_route_table" {
  subnet_id      = aws_subnet.smartpension_test_private_subnet_az_1.id
  route_table_id = aws_route_table.private_subnet_az_1_route_table.id
}

resource "aws_route_table" "private_subnet_az_2_route_table" {
  vpc_id = aws_vpc.smartpension_test.id

  route {
        cidr_block = "0.0.0.0/0"
        instance_id = aws_instance.nat.id
    }

  tags = {
    Name    = "smartpension-test private subnet az2 route table"
    Project = "smartpension-test"
  }
}

resource "aws_route_table_association" "private_subnet_az_2_route_table" {
  subnet_id      = aws_subnet.smartpension_test_private_subnet_az_2.id
  route_table_id = aws_route_table.private_subnet_az_1_route_table.id
}

resource "aws_route_table" "public_subnet_az_1_route_table" {
    vpc_id = aws_vpc.smartpension_test.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.smartpension_test.id
    }

    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_route_table_association" "public_subnet_az_1_route_table" {
    subnet_id = aws_subnet.smartpension_test_public_subnet_az_1.id
    route_table_id = aws_route_table.public_subnet_az_1_route_table.id
}

resource "aws_route_table" "public_subnet_az_2_route_table" {
    vpc_id = aws_vpc.smartpension_test.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.smartpension_test.id
    }

    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_route_table_association" "public_subnet_az_2_route_table" {
    subnet_id = aws_subnet.smartpension_test_public_subnet_az_2.id
    route_table_id = aws_route_table.public_subnet_az_2_route_table.id
}
