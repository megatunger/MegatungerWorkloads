variable "HEROKU_ACCOUNT_EMAIL" {}
variable "HEROKU_API_KEY" {}
variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_EDUMET_EDU_VN_ZONE_ID" {}
variable "CLOUDFLARE_API_KEY" {}

variable "APP_NAME" {
    default = "edumet"
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

resource "heroku_app" "edumet" {
    name = var.APP_NAME
    region = "eu"
}

resource "heroku_domain" "edumet" {
  app = heroku_app.ai_academy.id
  hostname = "edumet.edu.vn"
}

resource "heroku_build" "edumet" {
    app = heroku_app.edumet.id
    source = {
        url = "https://github.com/megatunger/EdumetLandingPage/archive/master.tar.gz"
    }
}

resource "cloudflare_record" "edumet_www" {
    name = "www"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_EDUMET_EDU_VN_ZONE_ID
    type = "CNAME"
    proxied = true
}

resource "cloudflare_record" "edumet" {
    name = "@"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_EDUMET_EDU_VN_ZONE_ID
    type = "CNAME"
    proxied = true
}