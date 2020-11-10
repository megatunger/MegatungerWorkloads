variable "HEROKU_ACCOUNT_EMAIL" {}
variable "HEROKU_API_KEY" {}
variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_API_KEY" {}
variable "CLOUDFLARE_SOLVEX_EDU_VN_ZONE_ID" {}
variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_BUCKET" {}
variable "AWS_REGION" {}
variable "AWS_SECRET_ACCESS_KEY" {}
variable "GITHUB_API_TOKEN" {}

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

resource "heroku_config" "solvex" {
    sensitive_vars = {
        AWS_ACCESS_KEY_ID = var.AWS_ACCESS_KEY_ID,
        AWS_REGION = var.AWS_REGION,
        AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY,
        AWS_BUCKET = var.AWS_BUCKET,
    }
}

resource "cloudflare_record" "solvex" {
    name = "solvex"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_SOLVEX_EDU_VN_ZONE_ID
    type = "CNAME"
    proxied = true
}

resource "cloudflare_record" "www_solvex" {
    name = "www.solvex"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_SOLVEX_EDU_VN_ZONE_ID
    type = "CNAME"
    proxied = true
}

resource "heroku_build" "solvex" {
    app = heroku_app.solvex.id
    buildpacks = ["https://github.com/heroku/heroku-buildpack-ruby.git", "https://github.com/heroku/heroku-buildpack-activestorage-preview"]
    source = {
        url = "https://api.github.com/repos/megatunger/OdingsProject/tarball?access_token=${var.GITHUB_API_TOKEN}"
    }
}