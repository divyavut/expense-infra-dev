
variable  "project_name" {
  type        = string
   default = "expense"
}
variable  "environment" {
  type        = string
  default     = "dev"
}

variable  "backend_tags" {
  type        = map
  default = {
    component = "backend"
  }
}
variable  "zone_name" {
  type        = string
 default = "dev.divyavutakanti.com"
}