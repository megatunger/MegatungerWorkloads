variable "HEROKU_ACCOUNT_EMAIL" {}
variable "HEROKU_API_KEY" {}
variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_API_KEY" {}
variable "CLOUDFLARE_MEGATUNGER_COM_ZONE_ID" {}

variable "APP_NAME" {
    default = "megatunger-blog"
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

resource "heroku_app" "megatunger_blog" {
    name = var.APP_NAME
    region = "eu"
}

resource "heroku_domain" "megatunger_blog" {
  app = heroku_app.megatunger_blog.id
  hostname = "megatunger.com"
}

resource "heroku_domain" "www_megatunger_blog" {
  app = heroku_app.megatunger_blog.id
  hostname = "www.megatunger.com"
}

resource "cloudflare_record" "megatunger" {
    name = "@"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
    type = "CNAME"
    proxied = true
}

resource "cloudflare_record" "www_megatunger" {
    name = "www"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
    type = "CNAME"
    proxied = true
}

resource "heroku_build" "megatunger_blog" {
    app = heroku_app.megatunger_blog.id
    source = {
        url = "https://github.com/megatunger/PersonalBlog/archive/master.tar.gz"
    }
}