# Auto-scaling group for Flask applications (YOLO and Depth Anything)
# Note: Auto-scaling policies are currently commented out
resource "aws_autoscaling_group" "ecs-autoscaling-group" {
    name                        = "ecs-autoscaling-group"
    max_size                    = "${var.max_instance_size}"
    min_size                    = "${var.min_instance_size}"
    desired_capacity            = "${var.desired_capacity}"
    vpc_zone_identifier         = ["${aws_subnet.test_public_sn_01.id}", "${aws_subnet.test_public_sn_02.id}"]
    
    launch_template {
      id      = aws_launch_template.ecs_launch_template_flask.id
      version = "$Latest"
    }
    
    # Health check type commented out since health checks are disabled
    # health_check_type           = "ELB"
}
