# CloudWatch Log Groups for ECS Services
resource "aws_cloudwatch_log_group" "yoloflask_log_group" {
  name              = "/ecs/${var.yoloflask_task_family}"
  retention_in_days = var.log_retention_days
  tags = {
    Environment = "production"
    Service     = "yoloflask"
  }
}

resource "aws_cloudwatch_log_group" "depthanythingflask_log_group" {
  name              = "/ecs/${var.depthanythingflask_task_family}"
  retention_in_days = var.log_retention_days
  tags = {
    Environment = "production"
    Service     = "depthanythingflask"
  }
}

resource "aws_cloudwatch_log_group" "objectdetectionreact_log_group" {
  name              = "/ecs/${var.objectdetectionreact_task_family}"
  retention_in_days = var.log_retention_days
  tags = {
    Environment = "production"
    Service     = "objectdetectionreact"
  }
}

# CloudWatch Log Group for ECS Cluster
resource "aws_cloudwatch_log_group" "ecs_cluster_log_group" {
  name              = "/ecs/${var.ecs_cluster}"
  retention_in_days = var.log_retention_days
  tags = {
    Environment = "production"
    Service     = "ecs-cluster"
  }
}

# Auto-scaling configuration commented out as requested
/*
# CloudWatch Alarm for High CPU Usage (Scale Up)
resource "aws_cloudwatch_metric_alarm" "ecs_cpu_high" {
  alarm_name          = "ecs-cpu-utilization-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.cpu_scale_up_threshold
  alarm_description   = "This metric monitors ECS CPU utilization for auto-scaling"
  alarm_actions       = [aws_autoscaling_policy.ecs_scale_up_policy.arn]

  dimensions = {
    ClusterName = var.ecs_cluster
  }
}

# CloudWatch Alarm for Low CPU Usage (Scale Down)
resource "aws_cloudwatch_metric_alarm" "ecs_cpu_low" {
  alarm_name          = "ecs-cpu-utilization-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.cpu_scale_down_threshold
  alarm_description   = "This metric monitors ECS CPU utilization for auto-scaling down"
  alarm_actions       = [aws_autoscaling_policy.ecs_scale_down_policy.arn]

  dimensions = {
    ClusterName = var.ecs_cluster
  }
}

# CloudWatch Alarm for Memory Usage (Scale Up)
resource "aws_cloudwatch_metric_alarm" "ecs_memory_high" {
  alarm_name          = "ecs-memory-utilization-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.memory_scale_up_threshold
  alarm_description   = "This metric monitors ECS memory utilization for auto-scaling"
  alarm_actions       = [aws_autoscaling_policy.ecs_scale_up_policy.arn]

  dimensions = {
    ClusterName = var.ecs_cluster
  }
}

# Auto Scaling Policy for Scale Up
resource "aws_autoscaling_policy" "ecs_scale_up_policy" {
  name                   = "ecs-scale-up-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.scale_up_cooldown
  autoscaling_group_name = aws_autoscaling_group.ecs-autoscaling-group.name
}

# Auto Scaling Policy for Scale Down
resource "aws_autoscaling_policy" "ecs_scale_down_policy" {
  name                   = "ecs-scale-down-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.scale_down_cooldown
  autoscaling_group_name = aws_autoscaling_group.ecs-autoscaling-group.name
}
*/ 