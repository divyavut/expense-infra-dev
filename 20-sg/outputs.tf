output "mysql_sg_id" {
    value = module.mysql_sg.mysql_sg_id
}
output "backend_sg_id" {
    value = module.backend_sg.backend_sg_id
}
output "frontend_sg_id" {
    value = module.frontend_sg.frontend_sg_id
}
output "bastion_sg_id" {
    value = module.bastion_sg.bastion_sg_id
}
output "ansible_sg_id" {
    value = module.ansible_sg.ansible_sg_id
}
output "app_lb_sg_id" {
    value = module.bastion_sg.app_lb_sg_id
}
output "web_alb_sg_id" {
    value = module.web_alb_sg.web_alb_sg_id
}
output "vpn_sg_id" {
    value = module.vpn_sg.vpn_sg_id
}
