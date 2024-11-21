
module "records_rds" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
 
  zone_name = var.zone_name

  records = [
   {
      name    = "mysql-${var.environment}"
      type    = "CNAME"
      ttl     = 1
      records = [local.db_instance_address]
      allow_overwrite  = true
    },
  ]
}
# create a domain for dns name of app load balancer *.app-dev.dev.divyavutakanti.com)
module "records_app_alb" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
 
  zone_name = var.zone_name

  records = [
   {
      name    = "*.app-${var.environment}"
      type    = "CNAME"
      ttl     = 1
      records = [local.app_alb_dns_name]
      allow_overwrite  = true
    },
  ]
}

# create a record in hosted zone  for dns name of web load balancer (expense-dev.dev.divyavutakanti.com)
module "records_web_alb" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
 
  zone_name = var.zone_name

  records = [
   {
      name    = "expense-${var.environment}"
      type    = "CNAME"
      ttl     = 1
      records = [local.web_alb_dns_name]
      allow_overwrite  = true
    },
  ]
}
