
resource "aws_ssm_parameter" "export_vpc_id" {
  name  = "/${var.project_name}/${var.environment}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "export_cidr_block" {
  name  = "/${var.project_name}/${var.environment}/cidr_block"
  type  = "StringList"
  value = module.vpc.expense_cidr
}
# Actually terraform list ["subnet1","subnet2"], Aws StringList subnet1,subnet2. 
# here we use join function to convert list to stringlist. return value "subnet1, subnet2"
resource "aws_ssm_parameter" "export_public_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/public_subnet_ids"
  type  = "StringList"
  value = join(",",module.vpc.public_subnet_ids)
}
resource "aws_ssm_parameter" "export_private_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/private_subnet_ids"
  type  = "StringList"
  value = join(",",module.vpc.private_subnet_ids)
}
resource "aws_ssm_parameter" "export_database_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/database_subnet_ids"
  type  = "StringList"
  # convert list(String) to StringList, return value "subnet1,subnet2"
  value = join(",",module.vpc.database_subnet_ids)
}

resource "aws_ssm_parameter" "export_database_subnet_group_name" {
  name  = "/${var.project_name}/${var.environment}/database_subnet_group_name"
  type  = "String"
  # convert list(String) to StringList, return value "subnet1,subnet2"
  value = module.vpc.database_subnet_group_name
}





