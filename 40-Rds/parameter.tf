resource "aws_ssm_parameter" "export_db_instance_address" {
  name  = "/${var.project_name}/${var.environment}/db_instance_address"
  type  = "StringList"
  value = module.db.db_instance_address
}