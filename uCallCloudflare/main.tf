variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_API_KEY" {}
variable "CLOUDFLARE_ZONE_ID" {}

terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.13.2"
    }
  }
}

provider "cloudflare" {
  email   = var.CLOUDFLARE_ACCOUNT_EMAIL
  api_key = var.CLOUDFLARE_API_KEY
}

resource "cloudflare_record" "ucall_sendgrid_1" {
  name    = "url3266.ucall.asia"
  value   = "sendgrid.net"
  zone_id = var.CLOUDFLARE_ZONE_ID
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "ucall_sendgrid_2" {
  name    = "13409028.ucall.asia"
  value   = "sendgrid.net"
  zone_id = var.CLOUDFLARE_ZONE_ID
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "ucall_sendgrid_3" {
  name    = "em14.ucall.asia"
  value   = "u13409028.wl029.sendgrid.net"
  zone_id = var.CLOUDFLARE_ZONE_ID
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "ucall_sendgrid_4" {
  name    = "s1._domainkey.ucall.asia"
  value   = "s1.domainkey.u13409028.wl029.sendgrid.net"
  zone_id = var.CLOUDFLARE_ZONE_ID
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "ucall_sendgrid_5" {
  name    = "s2._domainkey.ucall.asia"
  value   = "s2.domainkey.u13409028.wl029.sendgrid.net"
  zone_id = var.CLOUDFLARE_ZONE_ID
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "ucall_mailgun_1" {
  name    = "@"
  value   = "v=spf1 include:mailgun.org ~all"
  zone_id = var.CLOUDFLARE_ZONE_ID
  type    = "TXT"
  proxied = false
}

resource "cloudflare_record" "ucall_mailgun_2" {
  name    = "krs._domainkey.ucall.asia"
  value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4+6Fj+8RD3syKQyedy9+TkioW+9y7HgvHV7wBzy9bwT0P9hcq2yWoNq8vuH6DkcpsoAiRiXE88HHJh8ScSFuJT2QxQ1WbQQbcpJyW5lhpEWJenB3n07qDjHKjmj2flMVCwOZpMNlFNC0KfI080cU7yzffe93ADFVsy7inK52JbwIDAQAB"
  zone_id = var.CLOUDFLARE_ZONE_ID
  type    = "TXT"
  proxied = false
}

resource "cloudflare_record" "ucall_mailgun_3" {
  name    = "@"
  value   = "mxa.mailgun.org"
  zone_id = var.CLOUDFLARE_ZONE_ID
  type    = "MX"
  proxied = false
}

resource "cloudflare_record" "ucall_mailgun_4" {
  name    = "@"
  value   = "mxb.mailgun.org"
  zone_id = var.CLOUDFLARE_ZONE_ID
  type    = "MX"
  proxied = false
}

resource "cloudflare_record" "ucall_mailgun_5" {
  name    = "email.ucall.asia"
  value   = "mailgun.org"
  zone_id = var.CLOUDFLARE_ZONE_ID
  type    = "CNAME"
  proxied = false
}
