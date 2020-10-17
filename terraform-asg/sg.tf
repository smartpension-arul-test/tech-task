resource "aws_security_group" "smartpension-test-websg" {
  name = "security_group_for_rev_test_websg"
  ingress {
    from_port = 8090
    to_port = 8090
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  vpc_id = var.vpc_id
}

resource "aws_security_group" "smartpension-test-elbsg" {
  name = "security_group_for_elb"
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
  vpc_id = var.vpc_id
}
