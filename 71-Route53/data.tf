data "aws_ssm_parameter" "import_db_instance_address" {
  name = "/${var.project_name}/${var.environment}/db_instance_address"
}
data "aws_ssm_parameter" "import_app_alb_dns_name" {
 name  = "/${var.project_name}/${var.environment}/app_alb_dns_name"
}
data "aws_ssm_parameter" "import_web_alb_dns_name" {
 name  = "/${var.project_name}/${var.environment}/web_alb_dns_name"
}
  