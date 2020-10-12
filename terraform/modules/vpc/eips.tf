resource "aws_eip" "bastion" {
  instance = aws_instance.smartpension_test_bastion.id
  vpc      = true
}

resource "aws_eip" "smartpension_test_private_region_1_az_1" {
  vpc = true
}

resource "aws_eip" "smartpension_test_private_region_1_az_2" {
  vpc = true
}

output "bastion_ec2_public_ip" {
  value = aws_eip.bastion.public_ip
}
