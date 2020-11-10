variable "HEROKU_ACCOUNT_EMAIL" {}
variable "HEROKU_API_KEY" {}
variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_API_KEY" {}
variable "CLOUDFLARE_MEGATUNGER_COM_ZONE_ID" {}
variable "APP_NAME" {
    default = "solve-x"
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

resource "heroku_app" "solvex" {
    name = var.APP_NAME
    region = "eu"
}

resource "heroku_addon" "database" {
  app  = heroku_app.solvex.id
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_addon" "redis" {
  app  = heroku_app.solvex.id
  plan = "heroku-redis:hobby-dev"
}

resource "cloudflare_record" "testready" {
    name = "solvex"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
    type = "CNAME"
    proxied = true
}

resource "cloudflare_record" "www_testready" {
    name = "www.testready"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
    type = "CNAME"
    proxied = true
}

resource "heroku_build" "testready" {
    app = heroku_app.testready.id
    buildpacks = ["https://github.com/heroku/heroku-buildpack-ruby.git"]
    source = {
        url = "https://github.com/megatunger/testready/archive/master.tar.gz"
    }
}