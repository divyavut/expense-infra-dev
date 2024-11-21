locals {
    db_instance_address = data.aws_ssm_parameter.import_db_instance_address.value
    app_alb_dns_name = data.aws_ssm_parameter.import_app_alb_dns_name.value

    web_alb_dns_name = data.aws_ssm_parameter.import_web_alb_dns_name.value
    
}