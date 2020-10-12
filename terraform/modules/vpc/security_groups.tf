resource "aws_security_group" "smartpension_test_bastion_security_group" {
  name = "smartpension-test-bastion-security-group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  vpc_id = aws_vpc.smartpension_test.id

  tags = {
    Name    = "smartpension_test_bastion_security_group"
    Env     = "demo"
    Project = "smartpension-test"
  }
}

resource "aws_security_group" "smartpension_test_lambda_vpc_security_group" {
  name = "smartpension-test-lambda-vpc-security-group"

  egress {
    from_port = 0
    to_port   = 0

    // all protocols
    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  vpc_id = aws_vpc.smartpension_test.id

  tags = {
    Name    = "smartpension-test-lambda-vpc-security-group"
    Env     = "prod"
    Project = "smartpension-test"
  }
}

resource "aws_security_group" "smartpension_test_vpc_inbound" {
  name = "vpc_inbound"

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    security_groups = ["${aws_security_group.smartpension_test_lambda_vpc_security_group.id}",
      "${aws_security_group.smartpension_test_bastion_security_group.id}",
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  vpc_id = aws_vpc.smartpension_test.id

  tags = {
    Name    = "smartpension_test_vpc_inbound"
    Env     = "demo"
    Project = "smartpension-test"
  }
}
