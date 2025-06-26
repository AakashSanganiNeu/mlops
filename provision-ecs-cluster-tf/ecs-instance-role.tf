resource "aws_iam_role" "ecs-instance-role-tf" {
    name                = "ecs-instance-role-tf"
    path                = "/"
    assume_role_policy  = "${data.aws_iam_policy_document.ecs-instance-policy.json}"
}

data "aws_iam_policy_document" "ecs-instance-policy" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment" {
    role       = "${aws_iam_role.ecs-instance-role-tf.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# CloudWatch Logs policy for ECS instances
resource "aws_iam_role_policy" "ecs_cloudwatch_logs_policy" {
  name = "ecs-cloudwatch-logs-policy"
  role = aws_iam_role.ecs-instance-role-tf.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = [
          "arn:aws:logs:${var.region}:${var.aws_account_id}:log-group:/ecs/*",
          "arn:aws:logs:${var.region}:${var.aws_account_id}:log-group:/ecs/*:log-stream:*"
        ]
      }
    ]
  })
}

# CloudWatch Metrics policy for ECS instances
resource "aws_iam_role_policy" "ecs_cloudwatch_metrics_policy" {
  name = "ecs-cloudwatch-metrics-policy"
  role = aws_iam_role.ecs-instance-role-tf.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:PutMetricData",
          "ec2:DescribeVolumes",
          "ec2:DescribeTags",
          "logs:PutRetentionPolicy"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ecs-instance-profile-tf" {
    name = "ecs-instance-profile-tf"
    path = "/"
    role = "${aws_iam_role.ecs-instance-role-tf.name}"
    provisioner "local-exec" {
     command = "sleep 10"
    }
    # provisioner "local-exec" {
    #   command = "powershell.exe -Command \"Start-Sleep -Seconds 10\""
    # }
}
