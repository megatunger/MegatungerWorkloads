variable "HEROKU_ACCOUNT_EMAIL" {}
variable "HEROKU_API_KEY" {}
variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_API_KEY" {}
variable "CLOUDFLARE_MEGATUNGER_COM_ZONE_ID" {}
variable "GITHUB_API_TOKEN" {}
variable "APP_NAME" {
    default = "etron-service-api"
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

resource "heroku_app" "etron_api" {
    name = var.APP_NAME
    region = "eu"
}

resource "heroku_domain" "etron_api" {
  app = heroku_app.etron_api.id
  hostname = "etronapi.megatunger.com"
}

resource "heroku_build" "etron_api" {
    app = heroku_app.etron_api.id
    buildpacks = ["https://github.com/heroku/heroku-buildpack-python.git", "https://github.com/jonathanong/heroku-buildpack-ffmpeg-latest.git"]
    source = {
        url = "https://api.github.com/repos/megatunger/EtronTeam-Service/tarball?access_token=${var.GITHUB_API_TOKEN}"
    }
}

resource "cloudflare_record" "etron_api" {
    name = "etronapi"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
    type = "CNAME"
    proxied = true
}