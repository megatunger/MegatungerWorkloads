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

resource "cloudflare_record" "megatunger" {
    name = "@"
    value = "megatunger.github.io"
    zone_id = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
    type = "CNAME"
    proxied = true
}

resource "cloudflare_record" "www_megatunger" {
    name = "www"
    value = "megatunger.github.io"
    zone_id = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
    type = "CNAME"
    proxied = true
}