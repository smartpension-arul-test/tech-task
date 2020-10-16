data "aws_ami" "smartpension-test_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["smartpension-test*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["291213119936"]
}

#User data
data "template_file" "user_data" {
  template = file(var.user_data_file_path)
}

resource "aws_launch_configuration" "smartpension-test_lc" {
  image_id      = data.aws_ami.smartpension-test_ami.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.arulkeypair.key_name
  security_groups = [aws_security_group.smartpension-test-websg.id]
  lifecycle {
    create_before_destroy = true
  }
  user_data = data.template_file.user_data.rendered
}

resource "aws_autoscaling_group" "smartpension-test_asg" {
  name                 = "terraform-asg-rev-test-${aws_launch_configuration.smartpension-test_lc.name}"
  launch_configuration = aws_launch_configuration.smartpension-test_lc.name
  vpc_zone_identifier  =  var.public_subnet_ids
  min_size             = 1
  max_size             = 2

  load_balancers = [aws_elb.elb1.id]
  health_check_type = "ELB"

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "allzones" {}

resource "aws_elb" "elb1" {
  name = "terraform-elb-rev-test"
  availability_zones = ["${data.aws_availability_zones.allzones.names}"]
  security_groups = [aws_security_group.smartpension-test-elbsg.id]

  listener {
    instance_port = 8090
    instance_protocol = "http"
    lb_port = 8080
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:8090/healthcheck"
      interval = 30
  }

  cross_zone_load_balancing = true
  idle_timeout = 4000
  connection_draining = true
  connection_draining_timeout = 400

  tags = {
    Name = "terraform - elb - rev-test"
  }
}

resource "aws_key_pair" "arulkeypair" {
  key_name   = "arulkeypair1"
  public_key = var.id_rsa_pub
}
