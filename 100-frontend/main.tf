# Step 1: create frontend
module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami =                     local.ami_id
  name = local.resource_name
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.frontend_sg_id]
  subnet_id              = local.public_subnet_ids
 
  tags = {
        Name = local.resource_name
  }
}

# Step 2: confirgure frontend using ansible
resource "null_resource" "frontend" {
  # Changes to any instance requires re-provisioning
  triggers = {
    instance_id = module.frontend.id
  }

  # This connections only works when we connect to openvpn server using openvpn client
 connection {
    host     = module.frontend.private_ip 
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
  
  }
   provisioner "file" {
    source      = "${var.frontend_tags.component}.sh"
    destination = "/tmp/frontend.sh"
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/frontend.sh",
      "sudo sh /tmp/frontend.sh ${var.frontend_tags.component} ${var.environment}"
    ]
  }
}

# step 3: stop Ec2 instance 
resource "aws_ec2_instance_state" "frontend" {
  instance_id = module.frontend.id
  state       = "stopped" 
  depends_on = [null_resource.frontend]
}

resource "aws_ami_from_instance" "frontend" {
  name               = local.resource_name
  source_instance_id =  module.frontend.id
  depends_on = [aws_ec2_instance_state.frontend]
}

# step 4: delete the frontend instance

resource "null_resource" "frontend_delete" {
  # Changes to any instance requires re-provisioning
  triggers = {
    instance_id = module.frontend.id
  }
  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${module.frontend.id}"
    
  }
  depends_on = [aws_ami_from_instance.frontend]
}


resource "aws_launch_template" "frontend" {
  name = local.resource_name

  image_id = aws_ami_from_instance.frontend.id

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t3.micro"
  update_default_version = true
  vpc_security_group_ids = [local.frontend_sg_id]
  
    tags = {
      Name = local.resource_name
    }
  }

resource "aws_autoscaling_group" "frontend" {
  name                      = local.resource_name
  max_size                  = 10
  min_size                  = 2
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 2 # Satrting of the auto scaling group
  vpc_zone_identifier       = [local.public_subnet_ids]
  target_group_arns = [aws_lb_target_group.frontend.arn]
    launch_template {
    id      = aws_launch_template.frontend.id
    version = "$Latest"
  }
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }

  tag {
    key                 = "Name"
    value               = local.resource_name
    propagate_at_launch = true
  }
# if instances are not healthy within 15m , autoscaling will delete that instance
  timeouts {
    delete = "15m"
  }
}
resource "aws_autoscaling_policy" "frontend" {
  name                   = local.resource_name
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.frontend.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 70.0
  }
}

resource "aws_lb_target_group" "frontend" {
  name     = local.resource_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  health_check {
    healthy_threshold = 2
    matcher = "200-299"
    path = "/"
    port     = 80
    protocol = "HTTP"
    interval = 5
    timeout = 4
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "frontend" {
  listener_arn = local.web_alb_listener_arn_https
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }

 condition {
  # expense-dev.dev.divyavutakanti.com
    host_header {
      values = ["${var.project_name}-${var.environment}.${var.zone_name}"]
    }
  }
}

