variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_API_KEY" {}
variable "CLOUDFLARE_MEGATUNGER_COM_ZONE_ID" {}

terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "2.13.2"
    }
  }
}

provider "cloudflare" {
    email = var.CLOUDFLARE_ACCOUNT_EMAIL
    api_key = var.CLOUDFLARE_API_KEY
}

resource "cloudflare_record" "binhminh_erp_sendgrid_1" {
    name = "em1903.binhminh"
    value = "u13409028.wl029.sendgrid.net"
    zone_id = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
    type = "CNAME"
    proxied = false
}

resource "cloudflare_record" "binhminh_erp_sendgrid_2" {
    name = "s1._domainkey.binhminh"
    value = "s1.domainkey.u13409028.wl029.sendgrid.net"
    zone_id = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
    type = "CNAME"
    proxied = false
}

resource "cloudflare_record" "binhminh_erp_sendgrid_3" {
    name = "s2._domainkey.binhminh"
    value = "s2.domainkey.u13409028.wl029.sendgrid.net"
    zone_id = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
    type = "CNAME"
    proxied = false
}

resource "cloudflare_record" "binhminh_erp_sendgrid_4" {
    name = "url2654.binhminh"
    value = "sendgrid.net"
    zone_id = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
    type = "CNAME"
    proxied = false
}

resource "cloudflare_record" "binhminh_erp_sendgrid_5" {
    name = "13409028.binhminh"
    value = "sendgrid.net"
    zone_id = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
    type = "CNAME"
    proxied = false
}