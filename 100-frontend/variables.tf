
variable  "project_name" {
  type        = string
   default = "expense"
}
variable  "environment" {
  type        = string
  default     = "dev"
}

variable  "frontend_tags" {
  type        = map
  default = {
    component = "frontend"
  }
}
variable  "zone_name" {
  type        = string
 default = "dev.divyavutakanti.com"
}