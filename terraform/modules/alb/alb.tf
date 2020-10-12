resource "aws_security_group" "smartpension-test-alb-sg" {
    name = "smartpension-test-load-balancer"
    description = "allow HTTPS to smartpension-test Load Balancer (ALB)"
    vpc_id = var.vpc_id
    ingress {
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "smartpension-test-alb-sg"
    }
}

resource "aws_alb" "smartpension-test-alb" {
 name = "smartpension-test-alb"
 internal = false
 load_balancer_type = "application"

 security_groups = var.security-group-id
 subnets = var.subnet_id
 enable_deletion_protection = true
 tags = {
    Name = "smartpension-test-alb"
  }
 
}

resource "aws_alb_target_group" "smartpension-test-alb-tg" {
 name = "smartpension-test-tg"
 port = var.listen_port
 protocol = var.protocol
 vpc_id = var.vpc_id

  tags = {
    Name = "smartpension-test-alb"
  }
}

resource "aws_alb_listener" "smartpension-test-alb-listener" {
  load_balancer_arn = aws_alb.smartpension-test-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = var.ssl_arn

  default_action {
    target_group_arn = "${aws_alb_target_group.smartpension-test-alb-tg.arn}"
    type             = "forward"
  }
}

/*

 health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:80/index.html"
    interval            = 30
  }
*/
