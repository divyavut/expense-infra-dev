locals {
    resource_name = "${var.project_name}-${var.environment}-backend"
    backend_sg_id = data.aws_ssm_parameter.backend_sg_id.value
    # convert stringList to list , return ["subnet1", "subnet2"]
    private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)[0]
    ami_id = data.aws_ami.joindevops.id
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
     app_alb_listener_arn = data.aws_ssm_parameter.app_alb_listener_arn.value
}
