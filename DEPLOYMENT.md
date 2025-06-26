# MLOps Deployment Guide

This guide provides comprehensive instructions for deploying the MLOps Image Processing Platform to AWS using AWS CodeBuild and Terraform. The platform consists of three containerized applications:

1. **YOLO Flask API** - Object detection service (port 5001)
2. **Depth Anything Flask API** - Depth estimation service (port 5050)  
3. **React Frontend** - Web interface (port 80)

## Architecture Overview

The deployment creates:
- **AWS ECS Cluster** with auto-scaling EC2 instances
- **Application Load Balancer (ALB)** for traffic routing
- **ECR Repositories** for container images
- **CloudWatch** for logging and monitoring
- **Auto Scaling Groups** for high availability

## Prerequisites

### 1. AWS Prerequisites
- AWS CLI configured with appropriate permissions
- AWS Account with the following services enabled:
  - ECS (Elastic Container Service)
  - ECR (Elastic Container Registry)
  - EC2 (Elastic Compute Cloud)
  - ALB (Application Load Balancer)
  - CloudWatch
  - CodeBuild
- IAM permissions for ECS, ECR, EC2, ALB, CloudWatch, and CodeBuild

### 2. Local Prerequisites
- Terraform >= 0.12 installed
- Docker installed (for local testing)
- AWS CLI configured

### 3. ECR Repositories
Create the following ECR repositories in your AWS account:
```bash
aws ecr create-repository --repository-name yoloflask/api --region us-east-1
aws ecr create-repository --repository-name depthanythingflask/api --region us-east-1
aws ecr create-repository --repository-name objectdetectionreact/webapp --region us-east-1
```

## Build and Deployment Process

### Phase 1: CodeBuild (CI/CD Pipeline)

The `buildspec.yml` defines a multi-stage build process:

#### Pre-Build Phase
- Logs into Docker Hub to avoid rate limits
- Authenticates with AWS ECR

#### Build Phase
- Builds production Docker images for all three applications:
  - `depth-anything-flask-app` → ECR: `depthanythingflask/api:prod`
  - `yolo-v5-flask-app` → ECR: `yoloflask/api:prod`
  - `object-detection-react-app` → ECR: `objectdetectionreact/webapp:prod`

#### Post-Build Phase
- Pushes all images to ECR repositories

#### Required Environment Variables for CodeBuild:
```bash
AWS_REGION=us-east-1
AWS_ACCOUNT_ID=<your-account-id>
DOCKERHUB_USERNAME=<your-dockerhub-username>
DOCKERHUB_PASSWORD=<your-dockerhub-password>
```

### Phase 2: Terraform Infrastructure Deployment

## Terraform Configuration

### Directory Structure
```
provision-ecs-cluster-tf/
├── provider.tf              # AWS provider configuration
├── variables.tf             # Variable definitions
├── terraform.tfvars        # Variable values (configure this!)
├── vpc.tf                   # VPC and networking
├── cluster.tf               # ECS cluster
├── ecs-instance-role.tf     # ECS instance IAM roles
├── ecs-service-role.tf      # ECS service IAM roles
├── launch-configuration.tf  # EC2 launch configuration
├── autoscaling-group.tf     # Auto scaling group
├── application-load-balancer.tf # ALB configuration
├── task-definition.tf       # ECS task definitions
├── service.tf               # ECS services
├── cloudwatch.tf            # Monitoring and logging
└── outputs.tf               # Infrastructure outputs
```

## terraform.tfvars Configuration

Create and configure `provision-ecs-cluster-tf/terraform.tfvars` with the following variables:

### Core Configuration (Required)
```hcl
# Basic cluster configuration
ecs_cluster           = "image-processing-cluster"
ecs_key_pair_name     = "your-aws-key-pair-name"  # MUST EXIST in AWS
region                = "us-east-1"
aws_account_id        = "123456789012"            # Your AWS Account ID

# VPC and Networking
test_vpc              = "image_processing_vpc"
test_network_cidr     = "10.0.0.0/16"
test_public_01_cidr   = "10.0.0.0/24"
test_public_02_cidr   = "10.0.10.0/24"
```

### Auto Scaling Configuration
```hcl
# Instance scaling
max_instance_size     = 4
min_instance_size     = 3
desired_capacity      = 3

# Instance types
instance_type         = "m4.2xlarge"    # General ECS instances
flask_instance_type   = "m4.large"      # Flask API instances
react_instance_type   = "m4.large"      # React app instances
```

### Container Configuration
```hcl
# Container images (ECR repository names)
yoloflask_image_name              = "yoloflask/api"
depthanythingflask_image_name     = "depthanythingflask/api"
objectdetectionreact_image_name   = "objectdetectionreact/webapp"

# Image tags
yoloflask_image_tag               = "prod"
depthanythingflask_image_tag      = "prod"
objectdetectionreact_image_tag    = "prod"

# Container ports
yoloflask_container_port          = 5001
depthanythingflask_container_port = 5050
objectdetectionreact_container_port = 80

# Container resource allocation
yoloflask_container_memory        = 1024
depthanythingflask_container_memory = 1024
objectdetectionreact_container_memory = 512
yoloflask_container_cpu           = 0      # 0 = no hard limit
depthanythingflask_container_cpu  = 0
objectdetectionreact_container_cpu = 0
```

### Task Definition Configuration
```hcl
# Task CPU and Memory (for ECS task definitions)
yoloflask_task_cpu                = "1024"
depthanythingflask_task_cpu       = "1024"
objectdetectionreact_task_cpu     = "512"
yoloflask_task_memory             = "2048"
depthanythingflask_task_memory    = "2048"
objectdetectionreact_task_memory  = "2048"
```

### Load Balancer Configuration
```hcl
# Load balancer
alb_name                               = "ecs-load-balancer"
yoloflask_target_group_name           = "ecstargetgroupyolo"
depthanythingflask_target_group_name  = "ecstargetgroupdepth"
objectdetectionreact_target_group_name = "ecstargetgroupreact"
```

### Service Configuration
```hcl
# ECS Services
yoloflask_service_name              = "yoloflask-ecs-service"
depthanythingflask_service_name     = "depthanythingflask-ecs-service"
objectdetectionreact_service_name   = "objectdetectionreact-ecs-service"

# Task families
yoloflask_task_family               = "yoloflask-task-definition"
depthanythingflask_task_family      = "depthanythingflask-task-definition"
objectdetectionreact_task_family    = "objectdetectionreact-task-definition"
```

### Infrastructure Configuration
```hcl
# Launch configuration
ami_id                   = "ami-0b94e09a36bbbb349"  # ECS-optimized AMI
root_volume_size         = 100
root_volume_type         = "standard"
launch_configuration_name = "ecs-launch-image-processing-configuration"

# Security
ssh_port                 = 22
http_port                = 80
```

### Health Check Configuration
```hcl
# Load balancer health checks
health_check_healthy_threshold   = 2
health_check_unhealthy_threshold = 2
health_check_interval            = 30
health_check_timeout             = 20
health_check_matcher             = "200"
```

### CloudWatch and Auto Scaling
```hcl
# Auto-scaling thresholds
memory_scale_up_threshold = 80
evaluation_periods        = 2
alarm_period              = 300
scale_up_cooldown         = 300
scale_down_cooldown       = 300

# CloudWatch log retention
log_retention_days        = 7
```

### Container Names
```hcl
# Container naming
ecs_task_execution_role_name        = "ecsTaskExecutionRole"
yoloflask_container_name            = "yoloflask-api"
depthanythingflask_container_name   = "depthanythingflask-api"
objectdetectionreact_container_name = "objectdetectionreact-webapp"
```

## Deployment Steps

### Step 1: Prepare Infrastructure Code
```bash
# Clone the repository
git clone <repository-url>
cd mlops/provision-ecs-cluster-tf

# Configure terraform.tfvars with your values
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your specific configuration
```

### Step 2: Initialize Terraform
```bash
terraform init
```

### Step 3: Plan Deployment
```bash
terraform plan
```

### Step 4: Apply Infrastructure
```bash
terraform apply
```

### Step 5: Build and Deploy Applications (CodeBuild)
```bash
# Option 1: Use AWS CodeBuild console to trigger the build
# Option 2: Use AWS CLI
aws codebuild start-build --project-name <your-codebuild-project-name>

# Option 3: Manual Docker build and push (if not using CodeBuild)
./scripts/build-and-push.sh
```

## Post-Deployment

### Access URLs
After successful deployment, Terraform will output:
- **Load Balancer DNS**: Access point for the application
- **Complete Frontend URL**: Direct link to the React frontend with API endpoints configured

### Application Routes
- **Frontend**: `http://<alb-dns-name>/`
- **YOLO API**: `http://<alb-dns-name>/yoloapi/*`
- **Depth API**: `http://<alb-dns-name>/depthapi/*`

### Monitoring
- **CloudWatch Logs**: Available in log groups `/ecs/<task-family-name>`
- **CloudWatch Metrics**: ECS cluster and service metrics
- **Auto Scaling**: Configured based on CPU and memory thresholds

## Troubleshooting

### Common Issues

1. **ECR Repository Not Found**
   - Ensure ECR repositories are created before deployment
   - Check repository names match terraform.tfvars

2. **Task Definition Failures**
   - Verify AWS account ID is correct
   - Check ECR images exist and are accessible
   - Ensure ECS task execution role has permissions

3. **Load Balancer Health Check Failures**
   - Verify container ports match health check configuration
   - Check security group rules allow traffic
   - Review application logs in CloudWatch

4. **Auto Scaling Issues**
   - Verify CloudWatch alarms are properly configured
   - Check IAM roles have auto-scaling permissions

### Useful Commands

```bash
# Check ECS cluster status
aws ecs describe-clusters --clusters image-processing-cluster

# View running tasks
aws ecs list-tasks --cluster image-processing-cluster

# Check service status
aws ecs describe-services --cluster image-processing-cluster --services yoloflask-ecs-service

# View CloudWatch logs
aws logs describe-log-groups --log-group-name-prefix "/ecs/"

# Scale services manually
aws ecs update-service --cluster image-processing-cluster --service yoloflask-ecs-service --desired-count 2
```

## Cleanup

To destroy all infrastructure:
```bash
cd provision-ecs-cluster-tf
terraform destroy
```

⚠️ **Warning**: This will permanently delete all resources including data in CloudWatch logs.

## Security Considerations

1. **IAM Roles**: Follow principle of least privilege
2. **Security Groups**: Restrict access to necessary ports only
3. **VPC**: Use private subnets for enhanced security
4. **ECR**: Enable vulnerability scanning
5. **ALB**: Consider enabling HTTPS/SSL termination

## Cost Optimization

1. **Instance Types**: Use appropriate instance types for workload
2. **Auto Scaling**: Configure aggressive scale-down policies
3. **CloudWatch**: Set appropriate log retention periods
4. **ECR**: Implement lifecycle policies for image cleanup

## Support

For issues and questions:
1. Check CloudWatch logs for application errors
2. Review AWS ECS console for service health
3. Verify Terraform state matches deployed infrastructure
4. Consult AWS documentation for service-specific troubleshooting

## Authors & Credits

• Repo: [AakashSanganiNeu/mlops](https://github.com/AakashSanganiNeu/mlops)
• Built as part of *CSYE7220 DevOps Final Project*
• Supervised by *Prof. Dino Konstantopoulos*
• Team: Aakash and Tarun

--- 