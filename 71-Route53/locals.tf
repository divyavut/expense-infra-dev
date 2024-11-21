locals {
    db_instance_address = data.aws_ssm_parameter.db_instance_address.value
    app_alb_dns_name = data.aws_ssm_parameter.app_alb_dns_name.value

    web_alb_dns_name = data.aws_ssm_parameter.web_alb_dns_name.value
    
}