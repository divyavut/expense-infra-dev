variable  "project_name" {
  type        = string
   default = "expense"
}
variable  "environment" {
  type        = string
  default     = "dev"
}
variable "web_alb_tags" {
    type = string
    default = "web-alb"
}