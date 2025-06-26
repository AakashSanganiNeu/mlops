variable "ecs_cluster" {
  description = "ECS cluster name"
}

variable "ecs_key_pair_name" {
  description = "ECS key pair name"
}

variable "region" {
  description = "AWS region"
}

variable "availability_zone" {
  description = "availability zone used, based on region"
  default = {
    us-east-1 = "us-east-1"
  }
}

########################### VPC Config ################################

variable "test_vpc" {
  description = "VPC for Test environment"
}

variable "test_network_cidr" {
  description = "IP addressing for Test Network"
}

variable "test_public_01_cidr" {
  description = "Public 0.0 CIDR for externally accessible subnet"
}

variable "test_public_02_cidr" {
  description = "Public 0.0 CIDR for externally accessible subnet"
}

########################### Autoscale Config ################################

variable "max_instance_size" {
  description = "Maximum number of instances in the cluster"
}

variable "min_instance_size" {
  description = "Minimum number of instances in the cluster"
}

variable "desired_capacity" {
  description = "Desired number of instances in the cluster"
}

########################### ECR and Container Config ################################

variable "aws_account_id" {
  description = "AWS Account ID for ECR repositories"
  type        = string
}

variable "yoloflask_image_name" {
  description = "YOLO Flask container image name"
  type        = string
  default     = "yoloflask/api"
}

variable "depthanythingflask_image_name" {
  description = "Depth Anything Flask container image name"
  type        = string
  default     = "depthanythingflask/api"
}

variable "objectdetectionreact_image_name" {
  description = "Object Detection React container image name"
  type        = string
  default     = "objectdetectionreact/webapp"
}

variable "yoloflask_image_tag" {
  description = "YOLO Flask container image tag"
  type        = string
  default     = "prod"
}

variable "depthanythingflask_image_tag" {
  description = "Depth Anything Flask container image tag"
  type        = string
  default     = "prod"
}

variable "objectdetectionreact_image_tag" {
  description = "Object Detection React container image tag"
  type        = string
  default     = "prod"
}

variable "yoloflask_container_port" {
  description = "YOLO Flask container port"
  type        = number
  default     = 5001
}

variable "depthanythingflask_container_port" {
  description = "Depth Anything Flask container port"
  type        = number
  default     = 5050
}

variable "objectdetectionreact_container_port" {
  description = "Object Detection React container port"
  type        = number
  default     = 3000
}

variable "yoloflask_container_memory" {
  description = "YOLO Flask container memory allocation"
  type        = number
  default     = 512
}

variable "depthanythingflask_container_memory" {
  description = "Depth Anything Flask container memory allocation"
  type        = number
  default     = 512
}

variable "objectdetectionreact_container_memory" {
  description = "Object Detection React container memory allocation"
  type        = number
  default     = 512
}

variable "yoloflask_container_cpu" {
  description = "YOLO Flask container CPU allocation"
  type        = number
  default     = 0
}

variable "depthanythingflask_container_cpu" {
  description = "Depth Anything Flask container CPU allocation"
  type        = number
  default     = 0
}

variable "objectdetectionreact_container_cpu" {
  description = "Object Detection React container CPU allocation"
  type        = number
  default     = 0
}

########################### Launch Configuration Config ################################

variable "instance_type" {
  description = "EC2 instance type for ECS instances"
  type        = string
  default     = "t2.xlarge"
}

variable "ami_id" {
  description = "AMI ID for ECS instances"
  type        = string
  default     = "ami-fad25980"
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 100
}

variable "root_volume_type" {
  description = "Root volume type"
  type        = string
  default     = "standard"
}

########################### Load Balancer Config ################################

variable "alb_name" {
  description = "Application Load Balancer name"
  type        = string
  default     = "ecs-load-balancer"
}

variable "yoloflask_target_group_name" {
  description = "YOLO Flask target group name"
  type        = string
  default     = "ecstargetgroupyolo"
}

variable "depthanythingflask_target_group_name" {
  description = "Depth Anything Flask target group name"
  type        = string
  default     = "ecstargetgroupdepth"
}

variable "objectdetectionreact_target_group_name" {
  description = "Object Detection React target group name"
  type        = string
  default     = "ecstargetgroupreact"
}

variable "yoloflask_health_check_path" {
  description = "YOLO Flask health check path"
  type        = string
  default     = "/health"
}

variable "depthanythingflask_health_check_path" {
  description = "Depth Anything Flask health check path"
  type        = string
  default     = "/health"
}

variable "objectdetectionreact_health_check_path" {
  description = "Object Detection React health check path"
  type        = string
  default     = "/"
}

variable "yoloflask_service_name" {
  description = "YOLO Flask ECS service name"
  type        = string
  default     = "yoloflask-ecs-service"
}

variable "depthanythingflask_service_name" {
  description = "Depth Anything Flask ECS service name"
  type        = string
  default     = "depthanythingflask-ecs-service"
}

variable "objectdetectionreact_service_name" {
  description = "Object Detection React ECS service name"
  type        = string
  default     = "objectdetectionreact-ecs-service"
}

variable "yoloflask_task_family" {
  description = "YOLO Flask task definition family name"
  type        = string
  default     = "yoloflask-task-definition"
}

variable "depthanythingflask_task_family" {
  description = "Depth Anything Flask task definition family name"
  type        = string
  default     = "depthanythingflask-task-definition"
}

variable "objectdetectionreact_task_family" {
  description = "Object Detection React task definition family name"
  type        = string
  default     = "objectdetectionreact-task-definition"
}

variable "launch_configuration_name" {
  description = "Launch configuration name"
  type        = string
  default     = "ecs-launch-rockstar-configuration"
}

########################### Security Group Config ################################

variable "ssh_port" {
  description = "SSH port for security group"
  type        = number
  default     = 22
}

variable "http_port" {
  description = "HTTP port for security group"
  type        = number
  default     = 80
}

variable "http_alt_port" {
  description = "Alternative HTTP port for security group"
  type        = number
  default     = 8080
}

########################### ALB Listener Config ################################

variable "alb_listener_port" {
  description = "ALB listener port"
  type        = number
  default     = 8081
}

variable "alb_stickiness_duration" {
  description = "ALB stickiness duration in seconds"
  type        = number
  default     = 28800
}

variable "alb_listener_rule_priority" {
  description = "ALB listener rule priority"
  type        = number
  default     = 100
}

variable "yoloflask_path_patterns" {
  description = "Path patterns for YOLO Flask routing"
  type        = list(string)
  default     = ["/detect", "/health", "/model-info"]
}

variable "depthanythingflask_path_patterns" {
  description = "Path patterns for Depth Anything Flask routing"
  type        = list(string)
  default     = ["/predict_depth", "/health", "/model-info"]
}

variable "objectdetectionreact_path_patterns" {
  description = "Path patterns for Object Detection React routing"
  type        = list(string)
  default     = ["/"]
}

########################### Health Check Config ################################

variable "health_check_healthy_threshold" {
  description = "Health check healthy threshold"
  type        = number
  default     = 5
}

variable "health_check_unhealthy_threshold" {
  description = "Health check unhealthy threshold"
  type        = number
  default     = 2
}

variable "health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 5
}

variable "health_check_matcher" {
  description = "Health check matcher (HTTP status codes)"
  type        = string
  default     = "200"
}

########################### Task Definition Config ################################

variable "yoloflask_task_cpu" {
  description = "YOLO Flask task CPU allocation"
  type        = string
  default     = "1024"
}

variable "depthanythingflask_task_cpu" {
  description = "Depth Anything Flask task CPU allocation"
  type        = string
  default     = "1024"
}

variable "objectdetectionreact_task_cpu" {
  description = "Object Detection React task CPU allocation"
  type        = string
  default     = "1024"
}

variable "yoloflask_task_memory" {
  description = "YOLO Flask task memory allocation"
  type        = string
  default     = "3072"
}

variable "depthanythingflask_task_memory" {
  description = "Depth Anything Flask task memory allocation"
  type        = string
  default     = "3072"
}

variable "objectdetectionreact_task_memory" {
  description = "Object Detection React task memory allocation"
  type        = string
  default     = "3072"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  type        = string
  default     = "ecsTaskExecutionRole"
}

variable "yoloflask_container_name" {
  description = "YOLO Flask container name"
  type        = string
  default     = "yoloflask-api"
}

variable "depthanythingflask_container_name" {
  description = "Depth Anything Flask container name"
  type        = string
  default     = "depthanythingflask-api"
}

variable "objectdetectionreact_container_name" {
  description = "Object Detection React container name"
  type        = string
  default     = "objectdetectionreact"
}

########################### CloudWatch Auto Scaling Config ################################

variable "cpu_scale_up_threshold" {
  description = "CPU utilization threshold for scaling up"
  type        = number
  default     = 60
}

variable "cpu_scale_down_threshold" {
  description = "CPU utilization threshold for scaling down"
  type        = number
  default     = 30
}

variable "memory_scale_up_threshold" {
  description = "Memory utilization threshold for scaling up"
  type        = number
  default     = 80
}

variable "evaluation_periods" {
  description = "Number of evaluation periods for CloudWatch alarms"
  type        = number
  default     = 2
}

variable "alarm_period" {
  description = "Period in seconds for CloudWatch alarms"
  type        = number
  default     = 300
}

variable "scale_up_cooldown" {
  description = "Cooldown period in seconds for scale up actions"
  type        = number
  default     = 300
}

variable "scale_down_cooldown" {
  description = "Cooldown period in seconds for scale down actions"
  type        = number
  default     = 300
}

variable "log_retention_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
  default     = 7
}
########################### Instance Type Configuration ################################

variable "flask_instance_type" {
  description = "EC2 instance type for Flask applications (YOLO and Depth Anything)"
  type        = string
  default     = "m4.4xlarge"
}

variable "react_instance_type" {
  description = "EC2 instance type for React application"
  type        = string
  default     = "m4.2xlarge"
}

