output "vpc_id" {
  value = "${aws_vpc.smartpension_test.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.smartpension_test.cidr_block}"
}

output "db_subnet_group_name" {
  value = "${aws_db_subnet_group.smartpension_test_db_subnet.id}"
}

output "vpc_security_group_ids" {
  value = ["${aws_security_group.smartpension_test_vpc_inbound.id}"]
}

output "lambda_security_group_ids" {
  value = ["${aws_security_group.smartpension_test_lambda_vpc_security_group.id}"]
}

output "subnet_ids" {
  value = ["${aws_subnet.smartpension_test_public_subnet_1.id}", "${aws_subnet.smartpension_test_public_subnet_2.id}"]
}

output "public_subnet_id" {
  value = "${aws_subnet.smartpension_test_public_subnet_1.id}"
}

output "private_subnet_id" {
  value = ["${aws_subnet.smartpension_test_private_subnet_1.id}"]
}

output "igw_id" {
  value = aws_internet_gateway.smartpension_test.id
}
