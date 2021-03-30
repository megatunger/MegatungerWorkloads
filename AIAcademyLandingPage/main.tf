variable "HEROKU_ACCOUNT_EMAIL" {}
variable "HEROKU_ACCOUNT_MEGATUNGER_API_KEY" {}
variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_API_KEY" {}
variable "CLOUDFLARE_MEGATUNGER_COM_ZONE_ID" {}
variable "APP_NAME" {
    default = "ai-academy-landing-page"
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
  api_key = var.HEROKU_ACCOUNT_MEGATUNGER_API_KEY
}

provider "cloudflare" {
    email = var.CLOUDFLARE_ACCOUNT_EMAIL
    api_key = var.CLOUDFLARE_API_KEY
}

resource "heroku_app" "ai_academy" {
    name = var.APP_NAME
    region = "eu"
}

resource "heroku_domain" "ai_academy" {
  app = heroku_app.ai_academy.id
  hostname = "aialandingpage.megatunger.com"
}

resource "heroku_build" "ai_academy" {
    app = heroku_app.ai_academy.id
    source = {
        url = "https://github.com/megatunger/LandingPageForAIA/archive/master.tar.gz"
    }
}

resource "cloudflare_record" "ai_academy" {
    name = "aialandingpage"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
    type = "CNAME"
    proxied = true
}