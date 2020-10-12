resource "aws_instance" "smartpension_test_bastion" {
  ami                    = var.ins_ami
  key_name               = var.aws_key_name
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.smartpension_test_public_subnet_1.id
  vpc_security_group_ids = ["${aws_security_group.smartpension_test_bastion_security_group.id}"]
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }

  tags = {
    Name    = "smartpension_test bastion"
    Bastion = true
  }
}


