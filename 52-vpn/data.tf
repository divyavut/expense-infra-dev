data "aws_ssm_parameter" "vpn_sg_id" {
    #/expense/dev/vpn_sg_id
 name  = "/${var.project_name}/${var.environment}/vpn_sg_id"
}

# Terraform uses list(String) defined as ["subnet1", "subnet2"], AWS uses StringList defined as "subnet1,subnet2".
# To convert StringList to list(String), we use split(",", "foo,bar,baz") function
data "aws_ssm_parameter" "public_subnet_ids" {
name  = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

# data "aws_ami" "openvpnid" {
#   owners           = ["963363419609"]
#   most_recent      = true
#   filter {
#     name   = "name"
#     values = ["OpenVPN Access Server Community Image-8fbe3379-*"]
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
