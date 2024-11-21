module "mysql_sg" {
    source = "git::https://github.com/divyavut/terraform-aws-sg-module.git?ref=main"
    sg_name = "mysql"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id

}
module "backend_sg" {
    source = "git::https://github.com/divyavut/terraform-aws-sg-module.git?ref=main"
    sg_name = "backend"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id

}
module "app_lb_sg" {
    source = "git::https://github.com/divyavut/terraform-aws-sg-module.git?ref=main"
    sg_name = "app_alb" # expense-dev-app-alb
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
}

module "frontend_sg" {
    source = "git::https://github.com/divyavut/terraform-aws-sg-module.git?ref=main"
    sg_name = "frontend"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id

}
module "web_alb_sg" {
    source = "git::https://github.com/divyavut/terraform-aws-sg-module.git?ref=main"
    sg_name = "web-alb" # expense-dev-web-alb
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
}
module "bastion_sg" {
    source = "git::https://github.com/divyavut/terraform-aws-sg-module.git?ref=main"
    sg_name = "bastion"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
}
module "vpn_sg" {
    source = "git::https://github.com/divyavut/terraform-aws-sg-module.git?ref=main"
    sg_name = "vpn"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
}
module "ansible_sg" {
    source = "git::https://github.com/divyavut/terraform-aws-sg-module.git?ref=main"
    sg_name = "ansible"
    project_name = var.project_name
    environment = var.environment
    vpc_id = local.vpc_id
}



