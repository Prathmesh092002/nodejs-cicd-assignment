variable "domain_name" {
  description = "Public domain name for SSL certificate"
  type        = string
}
variable "route53_zone_id" {
  description = "Route53 Hosted Zone ID for SSL certificate DNS validation"
  type        = string
}
