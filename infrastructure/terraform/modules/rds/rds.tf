resource "aws_security_group" "smartpension_test_db_security_group" {
  name = "smartpension-test-db-security-group"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.public_subnet_cidr]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  vpc_id = var.vpc_id

  tags = {
    Name    = "smartpension_test_bastion_security_group"
    Env     = "demo"
    Project = "smartpension-test"
  }
}

resource "aws_db_instance" "smartpension_test" {
  allocated_storage         = 20
  backup_retention_period   = 2
  db_subnet_group_name      = var.db_subnet_group_name
  final_snapshot_identifier = "smartpension-test-final-snapshot"
  vpc_security_group_ids    = [aws_security_group.smartpension_test_db_security_group.id]
  skip_final_snapshot       = true

  # ssd
  storage_type   = "gp2"
  engine         = "mysql"
  instance_class = "db.t2.micro"
  name           = "smartpension_test"
  username       = "aruldemo"
  password       = var.db_password

  tags = {
    Name    = "mysql db"
    env     = "demo"
    project = "smartpension-test"
  }
}
