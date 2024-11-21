variable  "project_name" {
  type        = string
   default = "expense"
}
variable  "environment" {
  type        = string
  default     = "dev"
}
variable "internet_user" {
    type = list(string)
    default = ["0.0.0.0/0"]
}