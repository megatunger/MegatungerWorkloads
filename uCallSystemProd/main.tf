variable "HEROKU_ACCOUNT_EMAIL" {}
variable "HEROKU_API_KEY" {}
variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_API_KEY" {}
variable "CLOUDFLARE_ZONE_ID" {}
variable "APP_NAME" {
    default = "ucall-system-prod"
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

resource "heroku_app" "ucall_system_prod" {
    name = var.APP_NAME
    region = "eu"
}

resource "heroku_domain" "ucall_system_prod" {
  app = heroku_app.ucall_system_prod.id
  hostname = "api.ucall.cc"
}

resource "heroku_build" "ucall_system_prod" {
    app = heroku_app.ucall_system_prod.id
    buildpacks = ["https://github.com/heroku/heroku-buildpack-python.git"]
    source = {
        url = "https://api.github.com/repos/megatunger/ucall_manager/tarball?access_token=${var.GITHUB_API_TOKEN}"
    }
}

resource "cloudflare_record" "ucall_system_prod" {
    name = "api"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_ZONE_ID
    type = "CNAME"
    proxied = true
}