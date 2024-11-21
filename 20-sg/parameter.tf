resource "aws_ssm_parameter" "export_mysql_sg_id" {
  name  = "/${var.project_name}/${var.environment}/mysql_sg_id"
  type  = "StringList"
  value = module.mysql_sg.mysql_sg_id
}
resource "aws_ssm_parameter" "export_backend_sg_id" {
  name  = "/${var.project_name}/${var.environment}/backend_sg_id"
  type  = "StringList"
  value = module.backend_sg.backend_sg_id
}
resource "aws_ssm_parameter" "export_frontend_sg_id" {
  name  = "/${var.project_name}/${var.environment}/frontend_sg_id"
  type  = "StringList"
  value = module.frontend_sg.frontend_sg_id
}
resource "aws_ssm_parameter" "export_bastion_sg_id" {
  name  = "/${var.project_name}/${var.environment}/bastion_sg_id"
  type  = "StringList"
  value = module.bastion_sg.bastion_sg_id
}
resource "aws_ssm_parameter" "export_ansible_sg_id" {
  name  = "/${var.project_name}/${var.environment}/ansible_sg_id"
  type  = "StringList"
  value = module.ansible_sg.ansible_sg_id
}
resource "aws_ssm_parameter" "export_app_lb_sg_id" {
  name  = "/${var.project_name}/${var.environment}/app_lb_sg_id"
  type  = "StringList"
  value = module.app_lb_sg.app_lb_sg_id
}
resource "aws_ssm_parameter" "export_web_alb_sg_id" {
  name  = "/${var.project_name}/${var.environment}/web_alb_sg_id"
  type  = "StringList"
  value = module.web_alb_sg.web_alb_sg_id
}
resource "aws_ssm_parameter" "export_vpn_sg_id" {
  name  = "/${var.project_name}/${var.environment}/vpn_sg_id"
  type  = "StringList"
  value = module.vpn_sg.vpn_sg_id
}