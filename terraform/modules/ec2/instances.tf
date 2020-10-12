/*
  Rails Servers
*/
resource "aws_instance" "railsserver" {
    ami = var.ins_ami
    availability_zone = var.az_zone
    instance_type = var.instance_type
    key_name = var.aws_key_name
    vpc_security_group_ids = var.security_group_id
    subnet_id = var.public_subnet_id
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = "Rails Server"
        Web = true
    }
}
