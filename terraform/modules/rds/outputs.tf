output "rds_host_address" {
  value = "${aws_db_instance.smartpension_test.address}"
}

output "rds_instance_id" {
  value = "${aws_db_instance.smartpension_test.id}"
}

output "DB_PASSWORD" {
  value = "${aws_db_instance.smartpension_test.password}"
}

output "DB_HOST_ADDRESS" {
  value = "${aws_db_instance.smartpension_test.address}"
}
