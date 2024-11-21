data "aws_ssm_parameter" "import_mysql_sg" {
  name = "/${var.project_name}/${var.environment}/mysql_sg_id"
  
}
data "aws_ssm_parameter" "import_backend_sg" {
  name = "/${var.project_name}/${var.environment}/backend_sg_id"
}

data "aws_ssm_parameter" "import_frontend_sg" {
  name = "/${var.project_name}/${var.environment}/frontend_sg_id"
}

data "aws_ssm_parameter" "import_bastion_sg" {
  name = "/${var.project_name}/${var.environment}/bastion_sg_id"
}
data "aws_ssm_parameter" "import_ansible_sg" {
  name = "/${var.project_name}/${var.environment}/ansible_sg_id"
}
data "aws_ssm_parameter" "import_app_lb_sg_id" {
  name = "/${var.project_name}/${var.environment}/app_lb_sg_id"
}
data "aws_ssm_parameter" "import_web_alb_sg_id" {
  name = "/${var.project_name}/${var.environment}/web_alb_sg_id"
}
data "aws_ssm_parameter" "import_vpn_sg_id" {
  name = "/${var.project_name}/${var.environment}/vpn_sg_id"
}

