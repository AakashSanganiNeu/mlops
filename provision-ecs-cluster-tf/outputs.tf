output "region" {
  value = "${var.region}"
}

output "test_vpc_id" {
  value = "${aws_vpc.test_vpc.id}"
}

output "test_public_sn_01_id" {
  value = "${aws_subnet.test_public_sn_01.id}"
}

output "test_public_sn_02_id" {
  value = "${aws_subnet.test_public_sn_02.id}"
}

output "test_public_sg_id" {
  value = "${aws_security_group.test_public_sg.id}"
}

output "ecs-service-role-arn" {
  value = "${aws_iam_role.ecs-service-role.arn}"
}

output "ecs-instance-role-name" {
  value = "${aws_iam_role.ecs-instance-role-tf.name}"
}

output "ecs-load-balancer-name" {
    value = "${aws_alb.ecs-load-balancer.name}"
}

output "ecs-load-balancer-dns-name" {
  description = "The DNS name of the created ELB"
  value = "${aws_alb.ecs-load-balancer.dns_name}"
}

output "alb-zone-id" {
  description = "The zone ID of the ALB"
  value = "${aws_alb.ecs-load-balancer.zone_id}"
}

output "complete-frontend-url" {
  description = "Complete frontend URL with API endpoints as query parameters"
  value = "http://${aws_alb.ecs-load-balancer.dns_name}/?yoloapi=http://${aws_alb.ecs-load-balancer.dns_name}&depthapi=http://${aws_alb.ecs-load-balancer.dns_name}"
}

output "ecs-target-group-yoloflask-arn" {
    value = "${aws_alb_target_group.ecstargetgroupyolo.arn}"
}

output "ecs-target-group-depthanythingflask-arn" {
    value = "${aws_alb_target_group.ecstargetgroupdepth.arn}"
}

output "ecs-target-group-objectdetectionreact-arn" {
    value = "${aws_alb_target_group.ecstargetgroupreact.arn}"
}

########################### CloudWatch Outputs ################################

output "yoloflask_log_group_name" {
  description = "Name of the CloudWatch log group for YOLO Flask service"
  value       = aws_cloudwatch_log_group.yoloflask_log_group.name
}

output "depthanythingflask_log_group_name" {
  description = "Name of the CloudWatch log group for Depth Anything Flask service"
  value       = aws_cloudwatch_log_group.depthanythingflask_log_group.name
}

output "objectdetectionreact_log_group_name" {
  description = "Name of the CloudWatch log group for Object Detection React service"
  value       = aws_cloudwatch_log_group.objectdetectionreact_log_group.name
}

output "ecs_cluster_log_group_name" {
  description = "Name of the CloudWatch log group for ECS cluster"
  value       = aws_cloudwatch_log_group.ecs_cluster_log_group.name
}

# Auto-scaling outputs commented out as requested
/*
output "cpu_high_alarm_arn" {
  description = "ARN of the CPU high utilization alarm"
  value       = aws_cloudwatch_metric_alarm.ecs_cpu_high.arn
}

output "cpu_low_alarm_arn" {
  description = "ARN of the CPU low utilization alarm"
  value       = aws_cloudwatch_metric_alarm.ecs_cpu_low.arn
}

output "memory_high_alarm_arn" {
  description = "ARN of the memory high utilization alarm"
  value       = aws_cloudwatch_metric_alarm.ecs_memory_high.arn
}

output "scale_up_policy_arn" {
  description = "ARN of the scale up auto-scaling policy"
  value       = aws_autoscaling_policy.ecs_scale_up_policy.arn
}

output "scale_down_policy_arn" {
  description = "ARN of the scale down auto-scaling policy"
  value       = aws_autoscaling_policy.ecs_scale_down_policy.arn
}
*/
