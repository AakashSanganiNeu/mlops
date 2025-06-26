# Launch template for Flask applications (YOLO and Depth Anything) - m4.4xlarge
resource "aws_launch_template" "ecs_launch_template_flask" {
  name_prefix                 = "${var.launch_configuration_name}-flask"
  image_id                    = var.ami_id
  instance_type               = var.flask_instance_type
  key_name                    = var.ecs_key_pair_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs-instance-profile-tf.name
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.root_volume_size
      volume_type = var.root_volume_type
      delete_on_termination = true
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.test_public_sg.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.ecs_cluster} >> /etc/ecs/ecs.config
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.launch_configuration_name}-flask"
      Type = "flask-apps"
    }
  }
}
