variable "HEROKU_ACCOUNT_EMAIL" {}
variable "HEROKU_ACCOUNT_ETRON_TEAM_API_KEY" {}
variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_API_KEY" {}
variable "CLOUDFLARE_MEGATUNGER_COM_ZONE_ID" {}
variable "APP_NAME" {
    default = "lua-lep-api"
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

resource "heroku_app" "lualep" {
    name = var.APP_NAME
    region = "eu"
}

resource "heroku_domain" "lualep" {
  app = heroku_app.lualep.id
  hostname = "lualepapi.megatunger.com"
}

resource "heroku_build" "lualep" {
    app = heroku_app.lualep.id
    buildpacks = ["https://github.com/heroku/heroku-buildpack-python.git", "https://github.com/jonathanong/heroku-buildpack-ffmpeg-latest.git"]
    source = {
        url = "https://github.com/megatunger/Lua-Lep-Backend/archive/master.tar.gz"
    }
}

resource "cloudflare_record" "lualep" {
    name = "lualepapi"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
    type = "CNAME"
    proxied = true
}