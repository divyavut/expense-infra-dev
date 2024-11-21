locals {
    mysql_sg_id = data.aws_ssm_parameter.import_mysql_sg.value
    backend_sg_id = data.aws_ssm_parameter.import_backend_sg.value
    frontend_sg_id = data.aws_ssm_parameter.import_frontend_sg.value
    bastion_sg_id = data.aws_ssm_parameter.import_bastion_sg.value
    ansible_sg_id = data.aws_ssm_parameter.import_ansible_sg.value
    app_lb_sg_id = data.aws_ssm_parameter.import_app_lb_sg_id.value
    web_alb_sg_id = data.aws_ssm_parameter.import_web_alb_sg_id.value
    vpn_sg_id = data.aws_ssm_parameter.import_vpn_sg_id.value  
}

