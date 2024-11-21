data "aws_ssm_parameter" "backend_sg_id" {
    # /expense/dev/bastion_sg_id
name  = "/${var.project_name}/${var.environment}/backend_sg_id"
}

# Terraform uses list(String) defined as ["subnet1", "subnet2"], AWS uses StringList defined as "subnet1,subnet2".
# To convert StringList to list(String), we use split(",", "foo,bar,baz") function
data "aws_ssm_parameter" "private_subnet_ids" {
name  = "/${var.project_name}/${var.environment}/private_subnet_ids"
}
data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}


data "aws_ami" "joindevops" {
  owners           = ["973714476881"]
  most_recent      = true
  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "app_alb_listener_arn" {
  name  = "/${var.project_name}/${var.environment}/app_alb_listener_arn"
}