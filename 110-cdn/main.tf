# resource "aws_cloudfront_distribution" "expense" {
#   origin {
#     domain_name              = "${var.project_name}-${var.environment}.${var.zone_name}"
#     origin_id                = "${var.project_name}-${var.environment}.${var.zone_name}"
#     custom_origin_config {
#     http_port = 80
#     https_port  = 443
#     origin_ssl_protocols = ["TLSv1.2"]
#     origin_protocol_policy  = "https-only"
# }
#   }

#   enabled             = true

#   aliases = ["${var.project_name}-cdn.${var.environment}"]

# # dynamic content, evaluated at last, no cache
#   default_cache_behavior {
#     allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "${var.project_name}-${var.environment}.${var.zone_name}"

#     viewer_protocol_policy = "redirect-to-https"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#     cache_policy_id = data.aws_cloudfront_cache_policy.noCache.id
#   }

#   # Cache behavior with precedence 0
#   ordered_cache_behavior {
#     path_pattern     = "/images/*"
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD", "OPTIONS"]
#     target_origin_id = "${var.project_name}-${var.environment}.${var.zone_name}"
#     min_ttl                = 0
#     default_ttl            = 86400
#     max_ttl                = 31536000
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#     cache_policy_id = data.aws_cloudfront_cache_policy.Cache.id
#     }
#    # Cache behavior with precedence 1
#     ordered_cache_behavior {
#     path_pattern     = "/static/*"
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD", "OPTIONS"]
#     target_origin_id = "${var.project_name}-${var.environment}.${var.zone_name}"
#     min_ttl                = 0
#     default_ttl            = 86400
#     max_ttl                = 31536000
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#     cache_policy_id = data.aws_cloudfront_cache_policy.Cache.id
#     }

#   price_class = "PriceClass_200"

#   restrictions {
#     geo_restriction {
#       restriction_type = "whitelist"
#       locations        = ["US", "CA", "GB", "DE"]
#     }
#   }

#   tags = {
#     Name = local.resource_name
#   }

#   viewer_certificate {
#     acm_certificate_arn = local.https_certificate_arn
#     ssl_support_method = "sni-only"
#     minimum_protocol_version = "TLSv1.2_2021"
#   }
# }

# # create a record in hosted zone for cdn dns name (expense-cdn.dev.divyavutakanti.com)
# module "records_cdn" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
 
#   zone_name = var.zone_name

#   records = [
#    {
#       name    = "expense-cdn"
#       type    = "A"
#      alias = {
#       name =  aws_cloudfront_distribution.expense.domain_name
#       zone_id = aws_cloudfront_distribution.expense.hosted_zone_id # This belongs to CDN internal hosted zone id 
#      }
#     },
#   ]
# }




resource "aws_cloudfront_distribution" "expense" {
  origin {
    domain_name              = "${var.project_name}-${var.environment}.${var.zone_name}"
    origin_id                = "${var.project_name}-${var.environment}.${var.zone_name}"

    custom_origin_config {
        http_port = 80
        https_port = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols = ["TLSv1.2"]
    }
  }

  enabled             = true

  aliases = ["${var.project_name}-cdn.${var.zone_name}"]

  # dynamic content, evaluated at last no cache
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.project_name}-${var.environment}.${var.zone_name}"

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    cache_policy_id = data.aws_cloudfront_cache_policy.noCache.id
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/images/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${var.project_name}-${var.environment}.${var.zone_name}"

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id = data.aws_cloudfront_cache_policy.Cache.id
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/static/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${var.project_name}-${var.environment}.${var.zone_name}"

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id = data.aws_cloudfront_cache_policy.Cache.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["IN", "CA", "GB", "DE", "US"]
    }
  }

  tags = {
        Name = local.resource_name
    }
  viewer_certificate {
    acm_certificate_arn = local.https_certificate_arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name #daws81s.online
  records = [
    {
      name    = "expense-cdn" # *.app-dev
      type    = "A"
      alias   = {
        name    = aws_cloudfront_distribution.expense.domain_name
        zone_id = aws_cloudfront_distribution.expense.hosted_zone_id # This belongs CDN internal hosted zone, not ours
      }
      allow_overwrite = true
    }
  ]
}