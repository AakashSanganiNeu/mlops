resource "aws_ecs_service" "yoloflask-ecs-service" {
  	name            = var.yoloflask_service_name

	# Error: creating ECS Service (yoloflask-ecs-service): InvalidParameterException: 
	# You cannot specify an IAM role for services that require a service linked role
  	#iam_role        = "${aws_iam_role.ecs-service-role.name}"

  	cluster         = "${aws_ecs_cluster.my-ecs-cluster.id}"
  	task_definition = "${aws_ecs_task_definition.yoloflask_td.family}:${max("${aws_ecs_task_definition.yoloflask_td.revision}", "${data.aws_ecs_task_definition.yoloflask_td.revision}")}"
  	desired_count   = 1
	launch_type      = "EC2"
  	scheduling_strategy = "REPLICA"

	#network_configuration {
	#	assign_public_ip = true
	#	security_groups  = ["${aws_security_group.test_public_sg.id}"]
	#	subnets          = ["${aws_subnet.test_public_sn_01.id}", "${aws_subnet.test_public_sn_02.id}"]
	#}

  	load_balancer {
    	target_group_arn  = "${aws_alb_target_group.ecstargetgroupyolo.arn}"
    	container_port    = var.yoloflask_container_port
    	container_name    = var.yoloflask_container_name
	}
}

resource "aws_ecs_service" "depthanythingflask-ecs-service" {
  	name            = var.depthanythingflask_service_name

	# Error: creating ECS Service (depthanythingflask-ecs-service): InvalidParameterException: 
	# You cannot specify an IAM role for services that require a service linked role
  	#iam_role        = "${aws_iam_role.ecs-service-role.name}"

  	cluster         = "${aws_ecs_cluster.my-ecs-cluster.id}"
  	task_definition = "${aws_ecs_task_definition.depthanythingflask_td.family}:${max("${aws_ecs_task_definition.depthanythingflask_td.revision}", "${data.aws_ecs_task_definition.depthanythingflask_td.revision}")}"
  	desired_count   = 1
	launch_type      = "EC2"
  	scheduling_strategy = "REPLICA"

	#network_configuration {
	#	assign_public_ip = true
	#	security_groups  = ["${aws_security_group.test_public_sg.id}"]
	#	subnets          = ["${aws_subnet.test_public_sn_01.id}", "${aws_subnet.test_public_sn_02.id}"]
	#}

  	load_balancer {
    	target_group_arn  = "${aws_alb_target_group.ecstargetgroupdepth.arn}"
    	container_port    = var.depthanythingflask_container_port
    	container_name    = var.depthanythingflask_container_name
	}
}

resource "aws_ecs_service" "objectdetectionreact-ecs-service" {
  	name            = var.objectdetectionreact_service_name

	# Error: creating ECS Service (objectdetectionreact-ecs-service): InvalidParameterException: 
	# You cannot specify an IAM role for services that require a service linked role
  	#iam_role        = "${aws_iam_role.ecs-service-role.name}"

  	cluster         = "${aws_ecs_cluster.my-ecs-cluster.id}"
  	task_definition = "${aws_ecs_task_definition.objectdetectionreact_td.family}:${max("${aws_ecs_task_definition.objectdetectionreact_td.revision}", "${data.aws_ecs_task_definition.objectdetectionreact_td.revision}")}"
  	desired_count   = 1
	launch_type      = "EC2"
  	scheduling_strategy = "REPLICA"

	# network_configuration {
	# 	assign_public_ip = true
	# 	security_groups  = ["${aws_security_group.test_public_sg.id}"]
	# 	subnets          = ["${aws_subnet.test_public_sn_01.id}", "${aws_subnet.test_public_sn_02.id}"]
	# }

  	load_balancer {
    	target_group_arn  = "${aws_alb_target_group.ecstargetgroupreact.arn}"
    	container_port    = var.objectdetectionreact_container_port
    	container_name    = var.objectdetectionreact_container_name
	}
}
