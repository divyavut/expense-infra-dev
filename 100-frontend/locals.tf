locals {
    resource_name = "${var.project_name}-${var.environment}-frontend"
    frontend_sg_id = data.aws_ssm_parameter.frontend_sg_id.value
    # convert stringList to list , return ["subnet1", "subnet2"]
    public_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
    ami_id = data.aws_ami.joindevops.id
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    web_alb_listener_arn_https = data.aws_ssm_parameter.web_alb_listener_arn_https.value
}
