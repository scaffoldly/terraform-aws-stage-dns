[![Maintained by Scaffoldly](https://img.shields.io/badge/maintained%20by-scaffoldly-blueviolet)](https://github.com/scaffoldly)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/scaffoldly/terraform-aws-stage-dns)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.15.0-blue.svg)

## Description

For a given stage and domain parameters, create base DNS resources.

- ACM Certificate
- Verification Records
- MX Records

## Usage

```hcl
module "dns" {
  for_each = var.stages
  source   = "scaffoldly/aws/stage-dns"

  dns_provider      = var.dns_provider
  stage             = each.key
  domain            = each.value.domain
  subdomain         = var.serverless_api_subdomain
  subdomain_suffix  = each.value.subdomain_suffix != null ? each.value.subdomain_suffix : ""
  delegation_set_id = aws_route53_delegation_set.main.id
  stage_env_vars    = each.value.env_vars != null ? each.value.env_vars : {}

  providers = {
    aws.dns = aws.dns
  }
}
```

## Roadmap

- Deprecate this module
- Split up MX/ACM into separate modules
  - Separate ACM for Serverless/Cloudfront
- Remove aws_route53_delegation_set

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.33.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.33.0 |
| <a name="provider_aws.dns"></a> [aws.dns](#provider\_aws.dns) | 3.33.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.serverless_api_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.mx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.verification_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delegation_set_id"></a> [delegation\_set\_id](#input\_delegation\_set\_id) | The delegation set on Route53 | `string` | n/a | yes |
| <a name="input_dns_provider"></a> [dns\_provider](#input\_dns\_provider) | The DNS provider (Route53 currently only supported) | `string` | `"aws"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The domain for the application | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | The stage (e.g. live, nonlive) | `string` | n/a | yes |
| <a name="input_stage_env_vars"></a> [stage\_env\_vars](#input\_stage\_env\_vars) | A map of key/value pairs representing environment variables for the stage | `map(string)` | `{}` | no |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The subdomain for the stage | `string` | n/a | yes |
| <a name="input_subdomain_suffix"></a> [subdomain\_suffix](#input\_subdomain\_suffix) | The suffix to append to the subdomain (can be an empty string for no suffix) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_arn"></a> [certificate\_arn](#output\_certificate\_arn) | The ACM certificate for the serverless API domain |
| <a name="output_dns_domain_id"></a> [dns\_domain\_id](#output\_dns\_domain\_id) | The Route53 domain ID |
| <a name="output_dns_provider"></a> [dns\_provider](#output\_dns\_provider) | Re-output of var.dns\_provider |
| <a name="output_domain"></a> [domain](#output\_domain) | Re-output of var.domain |
| <a name="output_platform_domains"></a> [platform\_domains](#output\_platform\_domains) | A map of the domains managed in this stage |
| <a name="output_serverless_api_domain"></a> [serverless\_api\_domain](#output\_serverless\_api\_domain) | The computed Serverless API Domain |
| <a name="output_stage"></a> [stage](#output\_stage) | Re-output of var.stage |
| <a name="output_stage_env_vars"></a> [stage\_env\_vars](#output\_stage\_env\_vars) | The resultant environment variables for this stage |
| <a name="output_subdomain"></a> [subdomain](#output\_subdomain) | Re-output of var.subdomain |
| <a name="output_subdomain_suffix"></a> [subdomain\_suffix](#output\_subdomain\_suffix) | Re-output of var.subdomain\_suffix |
<!-- END_TF_DOCS -->
