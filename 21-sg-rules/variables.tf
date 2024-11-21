
variable  "project_name" {
  type        = string
   default = "expense"
}
variable  "environment" {
  type        = string
  default     = "dev"
}
# variable "mysql_sg_id" {
#     type = string
#     default = ""
# }
# variable "backend_sg_id" {
#     type = string
#     default = ""
# }
# variable "frontend_sg_id" {
#     type = string
#     default = ""
# }
# variable "bastion_sg_id" {
#     type = string
#     default = ""
# }
variable "internet_user" {
    type = list(string)
    default = ["0.0.0.0/0"]
}
# variable "app_lb_sg_id" {
#     type = string
#     default = ""
# }
# variable "web_alb_sg_id" {
#     type = string
#     default = ""
# }
# variable "vpn_sg_id" {
#     type = string
#     default = ""
# }

