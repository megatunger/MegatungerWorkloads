variable "HEROKU_ACCOUNT_EMAIL" {}
variable "HEROKU_API_KEY" {}
variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_ETRONRESEARCH_WORK_ZONE_ID" {}
variable "CLOUDFLARE_API_KEY" {}

variable "APP_NAME" {
    default = "ecall"
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

resource "heroku_app" "ecall" {
    name = var.APP_NAME
    region = "eu"
}

resource "heroku_domain" "ecall" {
  app = heroku_app.ecall.id
  hostname = "ecall.etronresearch.work"
}

resource "heroku_build" "ecall" {
    app = heroku_app.ecall.id
    source = {
        url = "https://github.com/megatunger/eCall/archive/main.tar.gz"
    }
}

resource "cloudflare_record" "ecall" {
    name = "ecall"
    value = "${var.APP_NAME}.herokuapp.com"
    zone_id = var.CLOUDFLARE_ETRONRESEARCH_WORK_ZONE_ID
    type = "CNAME"
    proxied = true
}