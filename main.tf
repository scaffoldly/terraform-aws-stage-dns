locals {
  mail_domain           = var.subdomain_suffix != "" ? "slyses-${var.subdomain_suffix}.${var.domain}" : "slyses.${var.domain}"
  serverless_api_domain = var.subdomain_suffix != "" ? "${var.subdomain}-${var.subdomain_suffix}.${var.domain}" : "${var.subdomain}.${var.domain}"
  stage_env_vars = merge(
    var.stage_env_vars,
    {
      SERVERLESS_API_DOMAIN = local.serverless_api_domain
      MAIL_DOMAIN           = local.mail_domain
  })
}

data "aws_region" "current" {}
data "aws_route53_zone" "zone" {
  name = "${var.domain}."

  provider = aws.dns
}

# TODO: Different Certs for CloudFront vs API Gateway
resource "aws_acm_certificate" "serverless_api_domain" {
  domain_name               = local.serverless_api_domain
  subject_alternative_names = [var.domain, "*.${var.domain}"]
  validation_method         = "DNS"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "verification_record" {
  for_each = {
    for dvo in aws_acm_certificate.serverless_api_domain.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 60
  type    = each.value.type
  zone_id = data.aws_route53_zone.zone.zone_id

  allow_overwrite = true # Dirty hack to allow wildcard certs to not collide

  provider = aws.dns
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.serverless_api_domain.arn
  validation_record_fqdns = values(aws_route53_record.verification_record)[*].fqdn
}

resource "aws_route53_record" "mx" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = local.mail_domain
  type    = "MX"
  ttl     = "300"
  records = ["10 inbound-smtp.${data.aws_region.current.name}.amazonaws.com"]

  provider = aws.dns
}
