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
