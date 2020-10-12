#######################
# Launch configuration
#######################
resource "aws_launch_configuration" "this" {
  count = "${var.create_lc}"

  name_prefix                 = "${coalesce(var.lc_name, var.name)}-"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${var.iam_instance_profile}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${var.security_groups}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data                   = "${var.user_data}"
  enable_monitoring           = "${var.enable_monitoring}"
  placement_tenancy           = "${var.placement_tenancy}"
  ebs_optimized               = "${var.ebs_optimized}"
  ebs_block_device            = "${var.ebs_block_device}"
  ephemeral_block_device      = "${var.ephemeral_block_device}"
  root_block_device           = "${var.root_block_device}"

  lifecycle {
    create_before_destroy = true
  }

  # spot_price                  = "${var.spot_price}"  // placement_tenancy does not work with spot_price
}

####################
# Autoscaling group
####################
resource "aws_autoscaling_group" "this" {
  count = "${var.create_asg}"

  name_prefix          = "${coalesce(var.asg_name, var.name)}-"
  launch_configuration = "${var.create_lc ? element(aws_launch_configuration.this.*.name, 0) : var.launch_configuration}"
  vpc_zone_identifier  = ["${var.vpc_zone_identifier}"]
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.desired_capacity}"

  load_balancers            = ["${var.load_balancers}"]
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"

  min_elb_capacity          = "${var.min_elb_capacity}"
  wait_for_elb_capacity     = "${var.wait_for_elb_capacity}"
  target_group_arns         = ["${var.target_group_arns}"]
  default_cooldown          = "${var.default_cooldown}"
  force_delete              = "${var.force_delete}"
  termination_policies      = "${var.termination_policies}"
  suspended_processes       = "${var.suspended_processes}"
  placement_group           = "${var.placement_group}"
  enabled_metrics           = ["${var.enabled_metrics}"]
  metrics_granularity       = "${var.metrics_granularity}"
  wait_for_capacity_timeout = "${var.wait_for_capacity_timeout}"
  protect_from_scale_in     = "${var.protect_from_scale_in}"

  tags = ["${concat(
      list(map("key", "Name", "value", var.name, "propagate_at_launch", true)),
      var.tags,
      local.tags_asg_format
   )}"]
}




resource "aws_autoscaling_group" "collect-asg" {
 name = "${var.env}-collect-${var.flavour}-asg"
 max_size = "${var.max-size}"
 min_size = "${var.min-size}"
 health_check_grace_period = 180
 health_check_type = "ELB"

 force_delete = "${var.force-delete}"
 launch_configuration = "${var.collect-asg-lc.name}"
 vpc_zone_identifier = ["${var.subnet-ids}"]

 target_group_arns = ["${var.tg-arns}"]
}