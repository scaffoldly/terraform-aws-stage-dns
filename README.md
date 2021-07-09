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

## Providers

## Modules

## Resources

## Inputs

## Outputs

<!-- END_TF_DOCS -->
