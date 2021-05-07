variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_API_KEY" {}
variable "CLOUDFLARE_ZONE_ID" {}
variable "CLOUDFLARE_ETRONRESEARCH_WORK_ZONE_ID" {}
variable "APP_NAME" {
  default = "ucall-landing-page"
}

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

resource "cloudflare_record" "ucall_landing_page_etron_research" {
  name    = "ucall"
  value   = "d18tcjznqkfbpt.cloudfront.net"
  zone_id = var.CLOUDFLARE_ETRONRESEARCH_WORK_ZONE_ID
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "www_ucall_landing_page_etron_research" {
  name    = "www.ucall"
  value   = "d18tcjznqkfbpt.cloudfront.net"
  zone_id = var.CLOUDFLARE_ETRONRESEARCH_WORK_ZONE_ID
  type    = "CNAME"
  proxied = true
}
