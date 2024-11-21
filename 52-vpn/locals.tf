locals {
    resource_name = "${var.project_name}-${var.environment}-vpn"
    vpn_sg_id = data.aws_ssm_parameter.vpn_sg_id.value
    # convert stringList to list , return ["subnet1", "subnet2"]
    public_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
    # ami_id = data.aws_ami.openvpnid.id
}
