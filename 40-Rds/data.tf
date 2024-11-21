
data "aws_ssm_parameter" "import_database_subnet_group_name" {
    # /expense/dev/database_subnet_group_name
name  = "/${var.project_name}/${var.environment}/database_subnet_group_name"
}
data "aws_ssm_parameter" "import_mysql_sg_id" {
    # /expense/dev/mysql_sg_id
name  = "/${var.project_name}/${var.environment}/mysql_sg_id"
}
# data "aws_ssm_parameter" "import_backend_sg_id" {
#     # /expense/dev/backend_sg_id
# name  = "/${var.project_name}/${var.environment}/backend_sg_id"
# }
# data "aws_ssm_parameter" "import_frontend_sg_id" {
#     # /expense/dev/frontend_sg_id
# name  = "/${var.project_name}/${var.environment}/frontend_sg_id"
# }
# data "aws_ssm_parameter" "import_ansible_sg_id" {
#     # /expense/dev/ansible_sg_id
# name  = "/${var.project_name}/${var.environment}/ansible_sg_id"
# }

# # Terraform uses list(String) defined as ["subnet1", "subnet2"], AWS uses StringList defined as "subnet1,subnet2".
# # To convert StringList to list(String), we use split(",", "foo,bar,baz") function
# data "aws_ssm_parameter" "import_public_subnet_ids" {
# name  = "/${var.project_name}/${var.environment}/public_subnet_ids"
# }
# data "aws_ssm_parameter" "import_database_subnet_ids" {
# name  = "/${var.project_name}/${var.environment}/database_subnet_ids"
# }
# data "aws_ssm_parameter" "import_private_subnet_ids" {
# name  = "/${var.project_name}/${var.environment}/private_subnet_ids"
# }
# data "aws_ami" "joindevops" {
#   owners           = ["973714476881"]
#   most_recent      = true
#   filter {
#     name   = "name"
#     values = ["RHEL-9-DevOps-Practice"]
#   }

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }