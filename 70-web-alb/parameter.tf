resource "aws_ssm_parameter" "export_web_alb_dns_name" {
  name  = "/${var.project_name}/${var.environment}/web_alb_dns_name"
  type  = "StringList"
  value = module.web_alb.dns_name
}
resource "aws_ssm_parameter" "export_web_alb_listener_arn" {
  name  = "/${var.project_name}/${var.environment}/web_alb_listener_arn"
  type  = "StringList"
  value = aws_lb_listener.http.arn
}
resource "aws_ssm_parameter" "export_web_alb_listener_arn_https" {
  name  = "/${var.project_name}/${var.environment}/web_alb_listener_arn_https"
  type  = "StringList"
  value = aws_lb_listener.https.arn
}