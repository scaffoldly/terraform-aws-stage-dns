variable "dns_provider" {
  type        = string
  default     = "aws"
  description = "The DNS provider (Route53 currently only supported)"
}
variable "stage" {
  type        = string
  description = "The stage (e.g. live, nonlive)"
}
variable "domain" {
  type        = string
  description = "The domain for the application"
}
variable "subdomain" {
  type        = string
  description = "The subdomain for the stage"
}
variable "subdomain_suffix" {
  type        = string
  description = "The suffix to append to the subdomain (can be an empty string for no suffix)"
}
variable "delegation_set_id" { # TODO Remove
  type        = string
  description = "The delegation set on Route53"
}
variable "stage_env_vars" {
  type        = map(string)
  default     = {}
  description = "A map of key/value pairs representing environment variables for the stage"
}
