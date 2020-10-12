resource "aws_db_instance" "smartpension_test" {
  allocated_storage         = 20
  backup_retention_period   = 2
  db_subnet_group_name      = var.db_subnet_group_name
  final_snapshot_identifier = "smartpension-test-final-snapshot"
  vpc_security_group_ids    = var.vpc_security_group_ids
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
