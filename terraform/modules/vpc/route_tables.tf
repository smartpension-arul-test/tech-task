resource "aws_route_table" "private_region_1_az_1" {
  vpc_id = aws_vpc.smartpension_test.id

  tags = {
    Name    = "smartpension-test private ${var.region_1_az_1} subnet route table"
    ENV     = "prod"
    Project = "smartpension-test"
  }
}


resource "aws_route_table" "private_region_1_az_2" {
  vpc_id = aws_vpc.smartpension_test.id

  tags = {
    Name    = "smartpension-test private ${var.region_1_az_2} subnet route table"
    ENV     = "prod"
    Project = "smartpension-test"
  }
}

/*
resource "aws_route" "private_region_1_az_1" {
  route_table_id         = aws_route_table.private_region_1_az_1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_instance.nat_1.id
}

resource "aws_route" "private_region_1_az_2" {
  route_table_id         = aws_route_table.private_region_1_az_2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_instance.nat_2.id
}



resource "aws_route_table" "smartpension_test_public" {
  vpc_id = aws_vpc.smartpension_test.id

  route {
    cidr_block = var.allow_all_cidr
    gateway_id = aws_internet_gateway.smartpension_test.id
  }

  tags = {
    Name    = "smartpension-test public subnet route table"
    ENV     = "prod"
    Project = "smartpension-test"
  }
}

*/

resource "aws_route_table_association" "smartpension_test_public_subnet_region_1_az_1" {
  subnet_id      = aws_subnet.smartpension_test_public_subnet_1.id
  route_table_id = aws_route_table.private_region_1_az_1.id
}

resource "aws_route_table_association" "smartpension_test_private_subnet_region_1_az_2" {
  subnet_id      = aws_subnet.smartpension_test_public_subnet_2.id
  route_table_id = aws_route_table.private_region_1_az_2.id
}
