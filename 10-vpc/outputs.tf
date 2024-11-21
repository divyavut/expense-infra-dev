output "vpc_id" {
    value = module.vpc.vpc_id
}
# output "paramter" {
#     value = module.vpc.vpc_id
# }
output "expense_cidr" {
    value = module.vpc.expense_cidr
}

# Output the AZ data from the module
# output "az_info_from_module" {
#  value = module.vpc.az_info
# }
# output "az_info_from_module" {
#  value = module.vpc.az_names
# }

# output "public_subnet_ids" {
#     value = module.vpc.public_subnet_ids[*]
# }
# output "private_subnet_ids" {
#     value = module.vpc.private_subnet_ids[*]
# }
# output "database_subnet_ids" {
#     value = module.vpc.database_subnet_ids[*]
# }
# # output "parameter_store" {
#     value = module.vpc.parameter_store
# }
# output "vpc_info" {
#     value = module.vpc.vpc_info
# }
output "default_vpc_id" {
    value = module.vpc.default_vpc_id
}
# output "default_rt_info" {
#     value = module.vpc.default_rt_info
# }
# output "aws_db_subnet_group" {
#      value = module.vpc.aws_db_subnet_group
# }
output "database_subnet_group_name" {
    value = module.vpc.database_subnet_group_name
}
