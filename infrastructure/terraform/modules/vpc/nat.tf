resource "aws_instance" "nat" {
    ami = "ami-30913f47" # this is a special ami preconfigured to do NAT
    availability_zone = var.az_1
    instance_type = "m1.small"
    key_name = var.aws_key_name
    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
    subnet_id = aws_subnet.smartpension_test_public_subnet_az_1.id
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = "VPC NAT"
    }
}

resource "aws_eip" "nat_eip" {
    instance = aws_instance.nat.id
    vpc = true
}






