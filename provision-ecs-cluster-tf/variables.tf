########################### Core Configuration ################################

variable "ecs_cluster" {
  description = "ECS cluster name"
  type        = string
}

variable "ecs_key_pair_name" {
  description = "ECS key pair name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}



########################### VPC Configuration ################################

variable "test_vpc" {
  description = "VPC for Test environment"
  type        = string
}

variable "test_network_cidr" {
  description = "IP addressing for Test Network"
  type        = string
}

variable "test_public_01_cidr" {
  description = "Public subnet 1 CIDR for externally accessible subnet"
  type        = string
}

variable "test_public_02_cidr" {
  description = "Public subnet 2 CIDR for externally accessible subnet"
  type        = string
}

########################### Autoscaling Configuration ################################

variable "max_instance_size" {
  description = "Maximum number of instances in the cluster"
  type        = number
}

variable "min_instance_size" {
  description = "Minimum number of instances in the cluster"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances in the cluster"
  type        = number
}

########################### Container Images Configuration ################################

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

########################### Container Configuration ################################

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

########################### Launch Configuration ################################

variable "instance_type" {
  description = "EC2 instance type for ECS instances"
  type        = string
  default     = "t2.xlarge"
}

variable "flask_instance_type" {
  description = "EC2 instance type for Flask applications"
  type        = string
  default     = "m4.4xlarge"
}

variable "react_instance_type" {
  description = "EC2 instance type for React application"
  type        = string
  default     = "m4.2xlarge"
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

variable "launch_configuration_name" {
  description = "Launch configuration name prefix"
  type        = string
  default     = "ecs-launch-configuration"
}

########################### Load Balancer Configuration ################################

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

########################### Security Group Configuration ################################

variable "ssh_port" {
  description = "SSH port number"
  type        = number
  default     = 22
}

variable "http_port" {
  description = "HTTP port number"
  type        = number
  default     = 80
}



########################### Health Check Configuration ################################

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

########################### Service Configuration ################################

variable "yoloflask_service_name" {
  description = "YOLO Flask service name"
  type        = string
  default     = "yoloflask-ecs-service"
}

variable "depthanythingflask_service_name" {
  description = "Depth Anything Flask service name"
  type        = string
  default     = "depthanythingflask-ecs-service"
}

variable "objectdetectionreact_service_name" {
  description = "Object Detection React service name"
  type        = string
  default     = "objectdetectionreact-ecs-service"
}

########################### Task Definition Configuration ################################

variable "yoloflask_task_family" {
  description = "YOLO Flask task family name"
  type        = string
  default     = "yoloflask-task-definition"
}

variable "depthanythingflask_task_family" {
  description = "Depth Anything Flask task family name"
  type        = string
  default     = "depthanythingflask-task-definition"
}

variable "objectdetectionreact_task_family" {
  description = "Object Detection React task family name"
  type        = string
  default     = "objectdetectionreact-task-definition"
}

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

########################### CloudWatch Auto Scaling Configuration ################################

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