output "domain" {
  value       = var.domain
  description = "Re-output of var.domain"
}

output "subdomain" {
  value       = var.subdomain
  description = "Re-output of var.subdomain"
}

output "subdomain_suffix" {
  value       = var.subdomain_suffix
  description = "Re-output of var.subdomain_suffix"
}

# TODO: Deprecate usage of this and use platform_domains downstream
output "serverless_api_domain" {
  value       = local.serverless_api_domain
  description = "The computed Serverless API Domain"
}

output "platform_domains" {
  value = {
    serverless_api_domain = local.serverless_api_domain
    mail_domain           = local.mail_domain
  }
  description = "A map of the domains managed in this stage"
}

output "stage" {
  value       = var.stage
  description = "Re-output of var.stage"
}

output "stage_env_vars" {
  value       = local.stage_env_vars
  description = "The resultant environment variables for this stage"
}

output "certificate_arn" {
  value       = aws_acm_certificate.serverless_api_domain.arn
  description = "The ACM certificate for the serverless API domain"
}

output "dns_provider" {
  value       = var.dns_provider
  description = "Re-output of var.dns_provider"
}

output "dns_domain_id" {
  value       = data.aws_route53_zone.zone.zone_id
  description = "The Route53 domain ID"
}
