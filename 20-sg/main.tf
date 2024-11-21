module "mysql_sg" {
    source = "https://github.com/divyavut/terraform-aws-sg.git?ref=main"
    sg_name = "mysql"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id

}
module "backend_sg" {
    source = "https://github.com/divyavut/terraform-aws-sg.git?ref=main"
    sg_name = "backend"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id

}
module "app_lb_sg" {
    source = "https://github.com/divyavut/terraform-aws-sg.git?ref=main"
    sg_name = "app_alb" # expense-dev-app-alb
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
}

module "frontend_sg" {
    source = "https://github.com/divyavut/terraform-aws-sg.git?ref=main"
    sg_name = "frontend"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id

}
module "web_alb_sg" {
    source = "https://github.com/divyavut/terraform-aws-sg.git?ref=main"
    sg_name = "web-alb" # expense-dev-web-alb
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
}
module "bastion_sg" {
    source = "https://github.com/divyavut/terraform-aws-sg.git?ref=main"
    sg_name = "bastion"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
}
module "vpn_sg" {
    source = "https://github.com/divyavut/terraform-aws-sg.git?ref=main"
    sg_name = "vpn"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
}
module "ansible_sg" {
    source = "https://github.com/divyavut/terraform-aws-sg.git?ref=main"
    sg_name = "ansible"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
}



# mysql allow connections on 3306 port from the instances which are connected to backend sg
resource "aws_security_group_rule" "mysql_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.backend_sg.id
  security_group_id = module.mysql_sg.id
}
# backend allow connections on 8080 port from only the application load balancer
resource "aws_security_group_rule" "backend_app_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_lb_sg.id
  security_group_id = module.backend_sg.id
}
# app_lb allow connections on 80 port from only frontend server
resource "aws_security_group_rule" "app_lb_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.frontend_sg.id
  security_group_id = module.app_lb_sg.id
}
# web loadbalancer allow connections on 80/ port from users(internet)
resource "aws_security_group_rule" "web_lb_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks      = [join("", var.internet_user)]
  security_group_id = module.web_alb_sg.id
}
# web loadbalancer allow connections on 443 port from users(internet)
resource "aws_security_group_rule" "web_lb_public_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks      = [join("", var.internet_user)]
  security_group_id = module.web_alb_sg.id
}

#  mysql server allow connections on 3306 port from the bastion host 
resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.mysql_sg.id
}
# backend  allow connections on 22 port from the bastion host 
resource "aws_security_group_rule" "backend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.backend_sg.id
}
# backend server allow connections on 8080 port from the bastion host 
resource "aws_security_group_rule" "backend_bastion_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.backend_sg.id
}
# application load balancer allow connections on 80 port from the bastion host 
resource "aws_security_group_rule" "app_lb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.app_lb_sg.id
}
# allow connections on 22 port from the bastion host to frontend server
resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.frontend_sg.id
# frontend server allow connections on 80 port from the bastion host 
resource "aws_security_group_rule" "frontend_bastion_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.frontend_sg.id
}
# frontend allow connections on 80 port from only web load balancer 
resource "aws_security_group_rule" "frontend_web_lb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.web_alb_sg.id
  security_group_id = module.frontend_sg.id
}
# frontend allow connections on 22 port from vpn
resource "aws_security_group_rule" "frontend_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.id
  security_group_id = module.frontend_sg.id
}
#  bastion server allow connections on 22 port from the public
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks      = [join("", var.internet_user)]
  security_group_id = module.bastion_sg.id
}

resource "aws_security_group_rule" "backend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.ansible_sg.id
  security_group_id = moduele.backend_sg.id
}
# allow connections on 22 port from the ansible host to frontend server
resource "aws_security_group_rule" "frontend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.ansible_sg.id
  security_group_id = module.frontend_sg.id
}
# vpn allow connections on 22 port from the public
resource "aws_security_group_rule" "vpn_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
   cidr_blocks      = [join("", var.internet_user)]
  security_group_id = module.vpn_sg.id
}
# vpn allow connections on 443 port from the public
resource "aws_security_group_rule" "vpn_public_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks      = [join("", var.internet_user)]
  security_group_id = module.vpn_sg.id
}
# vpn allow connections on 943 port from the public
resource "aws_security_group_rule" "vpn_public_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks      = [join("", var.internet_user)]
  security_group_id = module.vpn_sg.id
}
# vpn allow connections on 1194 port from the public
resource "aws_security_group_rule" "vpn_public_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks      = [join("", var.internet_user)]
  security_group_id = module.vpn_sg.id
}
# application load balancer allow connections on 80 port from vpn
resource "aws_security_group_rule" "app_lb_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.id
  security_group_id = module.app_lb_sg.id
}
# backend allow connections on 80 port from vpn
resource "aws_security_group_rule" "backend_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.id
  security_group_id = module.backend_sg.id
}

# backend allow connections on 8080 port from vpn
resource "aws_security_group_rule" "backend_vpn_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.id
  security_group_id = module.backend_sg.id
}



# # allow connections on 22 port from the public host to ansible server
# resource "aws_security_group_rule" "ansible_public" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks      = [join("", var.internet_user)]
#   security_group_id = var.ansible_sg_id
# }
# allow connections on 22 port from the public host to ansible server
#   