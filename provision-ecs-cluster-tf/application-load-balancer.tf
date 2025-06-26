# Application Load Balancer for path-based routing
resource "aws_alb" "ecs-load-balancer" {
    name                = var.alb_name
    internal            = false
    load_balancer_type  = "application"
    security_groups     = ["${aws_security_group.test_public_sg.id}"]
    subnets             = ["${aws_subnet.test_public_sn_01.id}", "${aws_subnet.test_public_sn_02.id}"]

    tags = {
      Name = var.alb_name
    }
}

# Target Group for YOLO Flask API (/yoloapi/*)
resource "aws_alb_target_group" "ecstargetgroupyolo" {
    name                = var.yoloflask_target_group_name
    port                = var.yoloflask_container_port
    protocol            = "HTTP"
    vpc_id              = "${aws_vpc.test_vpc.id}"
    
    health_check {
        enabled             = true
        healthy_threshold   = var.health_check_healthy_threshold
        unhealthy_threshold = var.health_check_unhealthy_threshold
        interval            = var.health_check_interval
        matcher             = var.health_check_matcher
        path                = "/yoloapi/health"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = var.health_check_timeout
    }
    
    tags = {
      Name = var.yoloflask_target_group_name
    }
}

# Target Group for Depth Flask API (/depthapi/*)
resource "aws_alb_target_group" "ecstargetgroupdepth" {
    name                = var.depthanythingflask_target_group_name
    port                = var.depthanythingflask_container_port
    protocol            = "HTTP"
    vpc_id              = "${aws_vpc.test_vpc.id}"

    health_check {
        enabled             = true
        healthy_threshold   = var.health_check_healthy_threshold
        unhealthy_threshold = var.health_check_unhealthy_threshold
        interval            = var.health_check_interval
        matcher             = var.health_check_matcher
        path                = "/depthapi/health"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = var.health_check_timeout
    }

    tags = {
      Name = var.depthanythingflask_target_group_name
    }
}

# Target Group for React Frontend (/)
resource "aws_alb_target_group" "ecstargetgroupreact" {
    name                = var.objectdetectionreact_target_group_name
    port                = var.objectdetectionreact_container_port
    protocol            = "HTTP"
    vpc_id              = "${aws_vpc.test_vpc.id}"

    health_check {
        enabled             = true
        healthy_threshold   = var.health_check_healthy_threshold
        unhealthy_threshold = var.health_check_unhealthy_threshold
        interval            = var.health_check_interval
        matcher             = var.health_check_matcher
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = var.health_check_timeout
    }

    tags = {
      Name = var.objectdetectionreact_target_group_name
    }
}

# ALB Listener on port 80
resource "aws_alb_listener" "alb_listener" {
    load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
    port              = "80"
    protocol          = "HTTP"

    # Default action forwards to React frontend
    default_action {
        type             = "forward"
        target_group_arn = aws_alb_target_group.ecstargetgroupreact.arn
    }
}

# Listener Rule for YOLO Flask API (/yoloapi/*)
resource "aws_lb_listener_rule" "yoloflask_rule" {
  listener_arn = aws_alb_listener.alb_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ecstargetgroupyolo.arn
  }

  condition {
    path_pattern {
      values = ["/yoloapi/*"]
    }
  }
}

# Listener Rule for Depth Flask API (/depthapi/*)
resource "aws_lb_listener_rule" "depthanythingflask_rule" {
  listener_arn = aws_alb_listener.alb_listener.arn
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ecstargetgroupdepth.arn
  }

  condition {
    path_pattern {
      values = ["/depthapi/*"]
    }
  }
}

