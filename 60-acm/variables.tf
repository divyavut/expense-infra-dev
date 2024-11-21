
variable  "project_name" {
  type        = string
   default = "expense"
}
variable  "environment" {
  type        = string
  default     = "dev"
}

# variable  "common_tags" {
#  default = {
#     Project = "expense"
#     Terraform = "true"
#     Environment = "dev"
#  }
# }
variable  "zone_name" {
  type        = string
  default     = "dev.divyavutakanti.com"
}
variable  "zone_id" {
  type        = string
  default     = "Z02510657KRVXNZGHI6U"
}