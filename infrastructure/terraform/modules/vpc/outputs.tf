output "vpc_id" {
  value = "${aws_vpc.smartpension_test.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.smartpension_test.cidr_block}"
}

output "db_subnet_group_name" {
  value = "${aws_db_subnet_group.smartpension_test_db_subnet.id}"
}

output "private_subnet_ids" {
  value = ["${aws_subnet.smartpension_test_private_subnet_az_1.id}", "${aws_subnet.smartpension_test_private_subnet_az_2.id}"]
}

output "public_subnet_ids" {
  value = ["${aws_subnet.smartpension_test_public_subnet_az_1.id}", "${aws_subnet.smartpension_test_public_subnet_az_2.id}"]
}

output "public_subnet_az_1_id" {
  value = "${aws_subnet.smartpension_test_public_subnet_az_1.id}"
}

output "public_subnet_az_2_id" {
  value = "${aws_subnet.smartpension_test_public_subnet_az_2.id}"
}

output "igw_id" {
  value = aws_internet_gateway.smartpension_test.id
}

output "bastion_ec2_public_ip" {
  value = aws_eip.bastion.public_ip
}

