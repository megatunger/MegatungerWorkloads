variable "HEROKU_ACCOUNT_EMAIL" {}
variable "HEROKU_API_KEY" {}
variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_ZONE_ID" {}
variable "CLOUDFLARE_API_KEY" {}
variable "GITHUB_API_TOKEN" {}

variable "APP_NAME_APP" {
  default = "ucall-app"
}

terraform {
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "3.0.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.13.2"
    }
  }
}


provider "heroku" {
  email   = var.HEROKU_ACCOUNT_EMAIL
  api_key = var.HEROKU_API_KEY
}

provider "cloudflare" {
  email   = var.CLOUDFLARE_ACCOUNT_EMAIL
  api_key = var.CLOUDFLARE_API_KEY
}

resource "heroku_app" "ucall_app" {
  name   = var.APP_NAME_APP
  region = "eu"
}

resource "heroku_domain" "ucall_app" {
  app      = heroku_app.ucall_app.id
  hostname = "app.ucall.asia"
}

resource "heroku_build" "ucall_app" {
  app = heroku_app.ucall_app.id
  source = {
    url = "https://api.github.com/repos/megatunger/uCall-App/tarball?access_token=${var.GITHUB_API_TOKEN}"
  }
}

resource "cloudflare_record" "ucall_app" {
  name    = "app"
  value   = "${var.APP_NAME_APP}.herokuapp.com"
  zone_id = var.CLOUDFLARE_ZONE_ID
  type    = "CNAME"
  proxied = true
}
