module "sg_rules" {
    source = "../../terraform-aws-security-rules"
    mysql_sg_id = local.mysql_sg_id
    backend_sg_id = local.backend_sg_id
    frontend_sg_id = local.frontend_sg_id
    bastion_sg_id = local.bastion_sg_id
    ansible_sg_id = local.ansible_sg_id
    internet_user = var.internet_user
    app_lb_sg_id = local.app_lb_sg_id
    web_alb_sg_id = local.web_alb_sg_id
    vpn_sg_id = local.vpn_sg_id
}