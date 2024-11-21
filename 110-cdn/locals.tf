  locals {
  resource_name = "${var.project_name}-${var.environment}"

  https_certificate_arn = data.aws_ssm_parameter.import_https_certificate_arn.value
  
  }
