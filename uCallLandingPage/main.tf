variable "HEROKU_ACCOUNT_EMAIL" {}
variable "HEROKU_API_KEY" {}
variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_API_KEY" {}
variable "CLOUDFLARE_ZONE_ID" {}
variable "APP_NAME" {
    default = "ucall-landing-page"
}

terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "3.0.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "2.13.2"
    }
  }
}

provider "heroku" {
  email = var.HEROKU_ACCOUNT_EMAIL
  api_key = var.HEROKU_API_KEY
}

provider "cloudflare" {
    email = var.CLOUDFLARE_ACCOUNT_EMAIL
    api_key = var.CLOUDFLARE_API_KEY
}

resource "heroku_app" "ucall_landing_page" {
    name = var.APP_NAME
    region = "eu"
}

resource "heroku_addon" "database" {
  app  = heroku_app.ucall_landing_page.id
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_domain" "ucall_landing_page" {
  app = heroku_app.ucall_landing_page.id
  hostname = "ucall.cc"
}

resource "heroku_domain" "www_ucall_landing_page" {
  app = heroku_app.ucall_landing_page.id
  hostname = "www.ucall.cc"
}

resource "cloudflare_record" "ucall_landing_page" {
    name = "ucall"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_ZONE_ID
    type = "CNAME"
    proxied = true
}

resource "cloudflare_record" "www_ucall_landing_page" {
    name = "www.ucall"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_ZONE_ID
    type = "CNAME"
    proxied = true
}

resource "heroku_build" "ucall_landing_page" {
    app = heroku_app.ucall_landing_page.id
    buildpacks = ["https://github.com/heroku/heroku-buildpack-ruby.git"]
    source = {
        url = "https://github.com/megatunger/uCall-Web/archive/master.tar.gz"
    }
}