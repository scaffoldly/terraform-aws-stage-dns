[![Maintained by Scaffoldly](https://img.shields.io/badge/maintained%20by-scaffoldly-blueviolet)](https://github.com/scaffoldly)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/scaffoldly/terraform-aws-stage-dns)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.15.0-blue.svg)

## Description

For a given stage and domain parameters, create base DNS resources.

- ACM Certificate
- Verification Records
- Generate MX record name

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

- Rename this module to infer ACM certificates only
- Use this module for Cloudfront
- Remove aws_route53_delegation_set

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.15   |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | ~> 3.33.0 |

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws)             | 3.33.0  |
| <a name="provider_aws.dns"></a> [aws.dns](#provider_aws.dns) | 3.33.0  |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.serverless_api_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.verification_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name                                                                                 | Description                                                                  | Type          | Default | Required |
| ------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------- | ------------- | ------- | :------: |
| <a name="input_delegation_set_id"></a> [delegation_set_id](#input_delegation_set_id) | The delegation set on Route53                                                | `string`      | n/a     |   yes    |
| <a name="input_dns_provider"></a> [dns_provider](#input_dns_provider)                | The DNS provider (Route53 currently only supported)                          | `string`      | `"aws"` |    no    |
| <a name="input_domain"></a> [domain](#input_domain)                                  | The domain for the application                                               | `string`      | n/a     |   yes    |
| <a name="input_stage"></a> [stage](#input_stage)                                     | The stage (e.g. live, nonlive)                                               | `string`      | n/a     |   yes    |
| <a name="input_stage_env_vars"></a> [stage_env_vars](#input_stage_env_vars)          | A map of key/value pairs representing environment variables for the stage    | `map(string)` | `{}`    |    no    |
| <a name="input_subdomain"></a> [subdomain](#input_subdomain)                         | The subdomain for the stage                                                  | `string`      | n/a     |   yes    |
| <a name="input_subdomain_suffix"></a> [subdomain_suffix](#input_subdomain_suffix)    | The suffix to append to the subdomain (can be an empty string for no suffix) | `string`      | n/a     |   yes    |

## Outputs

| Name                                                                                               | Description                                        |
| -------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| <a name="output_certificate_arn"></a> [certificate_arn](#output_certificate_arn)                   | The ACM certificate for the serverless API domain  |
| <a name="output_dns_domain_id"></a> [dns_domain_id](#output_dns_domain_id)                         | The Route53 domain ID                              |
| <a name="output_dns_provider"></a> [dns_provider](#output_dns_provider)                            | Re-output of var.dns_provider                      |
| <a name="output_domain"></a> [domain](#output_domain)                                              | Re-output of var.domain                            |
| <a name="output_platform_domains"></a> [platform_domains](#output_platform_domains)                | A map of the domains managed in this stage         |
| <a name="output_serverless_api_domain"></a> [serverless_api_domain](#output_serverless_api_domain) | The computed Serverless API Domain                 |
| <a name="output_stage"></a> [stage](#output_stage)                                                 | Re-output of var.stage                             |
| <a name="output_stage_env_vars"></a> [stage_env_vars](#output_stage_env_vars)                      | The resultant environment variables for this stage |
| <a name="output_subdomain"></a> [subdomain](#output_subdomain)                                     | Re-output of var.subdomain                         |
| <a name="output_subdomain_suffix"></a> [subdomain_suffix](#output_subdomain_suffix)                | Re-output of var.subdomain_suffix                  |

<!-- END_TF_DOCS -->
