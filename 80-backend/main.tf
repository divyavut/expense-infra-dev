# Step 1: create Backend
module "backend" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami =                     local.ami_id
  name = local.resource_name
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.backend_sg_id]
  subnet_id              = local.private_subnet_ids
 
  tags = {
        Name = local.resource_name
  }
}

# Step 2: confirgure backend using ansible
resource "null_resource" "backend" {
  # Changes to any instance requires re-provisioning
  triggers = {
    instance_id = module.backend.id
  }

  # This connections only works when we connect to openvpn server using openvpn client
 connection {
    host     = module.backend.private_ip 
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
  
  }
   provisioner "file" {
    source      = "${var.backend_tags.component}.sh"
    destination = "/tmp/backend.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/backend.sh",
      "sudo sh /tmp/backend.sh ${var.backend_tags.component} ${var.environment}"
    ]
  }
}

# step 3: stop Ec2 instance 
resource "aws_ec2_instance_state" "backend" {
  instance_id = module.backend.id
  state       = "stopped" 
  depends_on = [null_resource.backend]
}

resource "aws_ami_from_instance" "backend" {
  name               = local.resource_name
  source_instance_id =  module.backend.id
  depends_on = [aws_ec2_instance_state.backend]
}

# step 4: delete the backend instance

resource "null_resource" "backend_delete" {
  # Changes to any instance requires re-provisioning
  triggers = {
    instance_id = module.backend.id
  }
  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${module.backend.id}"
    
  }
  depends_on = [aws_ami_from_instance.backend]
}


resource "aws_launch_template" "backend" {
  name = local.resource_name

  image_id = aws_ami_from_instance.backend.id

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t3.micro"
  update_default_version = true
  vpc_security_group_ids = [local.backend_sg_id]
  
    tags = {
      Name = local.resource_name
    }
  }

resource "aws_autoscaling_group" "backend" {
  name                      = local.resource_name
  max_size                  = 10
  min_size                  = 2
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 2 # Satrting of the auto scaling group
  vpc_zone_identifier       = [local.private_subnet_ids]
  target_group_arns = [aws_lb_target_group.backend.arn]
    launch_template {
    id      = aws_launch_template.backend.id
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
resource "aws_autoscaling_policy" "backend" {
  name                   = local.resource_name
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.backend.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 70.0
  }
}

resource "aws_lb_target_group" "backend" {
  name     = local.resource_name
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  health_check {
    healthy_threshold = 2
    matcher = "200-299"
    path = "/health"
    port     = 8080
    protocol = "HTTP"
    interval = 5
    timeout = 4
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "backend" {
  listener_arn = local.app_alb_listener_arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }

 condition {
  # backend.app-dev.dev.divyavutakanti.com
    host_header {
      values = ["${var.backend_tags.component}.app-${var.environment}.${var.zone_name}"]
    }
  }
}