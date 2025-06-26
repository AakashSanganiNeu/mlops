data "aws_ecs_task_definition" "yoloflask_td" {
  task_definition = "${aws_ecs_task_definition.yoloflask_td.family}"
}

data "aws_ecs_task_definition" "depthanythingflask_td" {
  task_definition = "${aws_ecs_task_definition.depthanythingflask_td.family}"
}

data "aws_ecs_task_definition" "objectdetectionreact_td" {
  task_definition = "${aws_ecs_task_definition.objectdetectionreact_td.family}"
}

# For task definitions that only specify EC2 for the requiresCompatibilities parameter, 
# the supported CPU values are between 256 CPU units (0.25 vCPUs) and 16384 CPU units 
# (16 vCPUs). For task definitions that specify FARGATE for the requiresCompatibilities 
# parameter (even if EC2 is also specified), you must use one of the values in the 
# following table: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html

# YOLO Flask API Task Definition - serves /yoloapi/* paths
resource "aws_ecs_task_definition" "yoloflask_td" {
    family                = var.yoloflask_task_family
    cpu                   = var.yoloflask_task_cpu
    memory                = var.yoloflask_task_memory
    execution_role_arn    = "arn:aws:iam::${var.aws_account_id}:role/${var.ecs_task_execution_role_name}"
    network_mode          = "bridge"
    requires_compatibilities = ["EC2"]
    
    container_definitions = <<DEFINITION
[
  {
    "name": "${var.yoloflask_container_name}",
    "image": "${var.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.yoloflask_image_name}:${var.yoloflask_image_tag}",
    "cpu": ${var.yoloflask_container_cpu},
    "memoryReservation": ${var.yoloflask_container_memory},
    "essential": true,
    "portMappings": [
      {
        "name": "${var.yoloflask_container_name}-${var.yoloflask_container_port}-tcp",
        "containerPort": ${var.yoloflask_container_port},
        "hostPort": ${var.yoloflask_container_port},
        "protocol": "tcp",
        "appProtocol": "http"
      }
    ],
    "environment": [
      {
        "name": "PATH_PREFIX",
        "value": "/yoloapi"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${var.yoloflask_task_family}",
        "mode": "non-blocking",
        "awslogs-create-group": "true",
        "max-buffer-size": "25m",
        "awslogs-region": "${var.region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
DEFINITION
}

# Depth Anything Flask API Task Definition - serves /depthapi/* paths
resource "aws_ecs_task_definition" "depthanythingflask_td" {
    family                = var.depthanythingflask_task_family
    cpu                   = var.depthanythingflask_task_cpu
    memory                = var.depthanythingflask_task_memory
    execution_role_arn    = "arn:aws:iam::${var.aws_account_id}:role/${var.ecs_task_execution_role_name}"
    network_mode          = "bridge"
    requires_compatibilities = ["EC2"]
    
    container_definitions = <<DEFINITION
[
  {
    "name": "${var.depthanythingflask_container_name}",
    "image": "${var.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.depthanythingflask_image_name}:${var.depthanythingflask_image_tag}",
    "cpu": ${var.depthanythingflask_container_cpu},
    "memoryReservation": ${var.depthanythingflask_container_memory},
    "essential": true,
    "portMappings": [
      {
        "name": "${var.depthanythingflask_container_name}-${var.depthanythingflask_container_port}-tcp",
        "containerPort": ${var.depthanythingflask_container_port},
        "hostPort": ${var.depthanythingflask_container_port},
        "protocol": "tcp",
        "appProtocol": "http"
      }
    ],
    "environment": [
      {
        "name": "PATH_PREFIX",
        "value": "/depthapi"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${var.depthanythingflask_task_family}",
        "mode": "non-blocking",
        "awslogs-create-group": "true",
        "max-buffer-size": "25m",
        "awslogs-region": "${var.region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
DEFINITION
}

# React Frontend Task Definition - serves / path
resource "aws_ecs_task_definition" "objectdetectionreact_td" {
    family                = var.objectdetectionreact_task_family
    cpu                   = var.objectdetectionreact_task_cpu
    memory                = var.objectdetectionreact_task_memory
    execution_role_arn    = "arn:aws:iam::${var.aws_account_id}:role/${var.ecs_task_execution_role_name}"
    network_mode          = "bridge"
    requires_compatibilities = ["EC2"]
    
    container_definitions = <<DEFINITION
[
  {
    "name": "${var.objectdetectionreact_container_name}",
    "image": "${var.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.objectdetectionreact_image_name}:${var.objectdetectionreact_image_tag}",
    "cpu": ${var.objectdetectionreact_container_cpu},
    "memoryReservation": ${var.objectdetectionreact_container_memory},
    "essential": true,
    "portMappings": [
      {
        "name": "${var.objectdetectionreact_container_name}-${var.objectdetectionreact_container_port}-tcp",
        "containerPort": ${var.objectdetectionreact_container_port},
        "hostPort": 80,
        "protocol": "tcp",
        "appProtocol": "http"
      }
    ],
    "environment": [
      {
        "name": "REACT_APP_YOLO_API_URL",
        "value": "/yoloapi"
      },
      {
        "name": "REACT_APP_DEPTH_API_URL",
        "value": "/depthapi"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${var.objectdetectionreact_task_family}",
        "mode": "non-blocking",
        "awslogs-create-group": "true",
        "max-buffer-size": "25m",
        "awslogs-region": "${var.region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
DEFINITION
}
