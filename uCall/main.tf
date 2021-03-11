variable "HEROKU_ACCOUNT_EMAIL" {}
variable "HEROKU_API_KEY" {}
variable "CLOUDFLARE_ACCOUNT_EMAIL" {}
variable "CLOUDFLARE_ETRONRESEARCH_WORK_ZONE_ID" {}
variable "CLOUDFLARE_API_KEY" {}
variable "GITHUB_API_TOKEN" {}

variable "APP_NAME_LANDING_PAGE" {
    default = "ucall"
}

variable "APP_NAME_APP" {
    default = "ucall-app"
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

resource "heroku_app" "ucall_landingpage" {
    name = var.APP_NAME_LANDING_PAGE
    region = "eu"
}

resource "heroku_app" "ucall_app" {
    name = var.APP_NAME_APP
    region = "eu"
}

resource "heroku_domain" "ucall" {
  app = heroku_app.ucall_landingpage.id
  hostname = "ucall.etronresearch.work"
}

resource "heroku_domain" "ucall_app" {
  app = heroku_app.ucall_app.id
  hostname = "ucall-app.etronresearch.work"
}

resource "heroku_build" "ucall_app" {
    app = heroku_app.ucall_app.id
    source = {
        url = "https://api.github.com/repos/megatunger/eCall/tarball?access_token=${var.GITHUB_API_TOKEN}"
    }
}

resource "heroku_build" "ucall_landingpage" {
    app = heroku_app.ucall_landingpage.id
    source = {
        url = "https://github.com/megatunger/eCall-LandingPage/archive/main.tar.gz"
    }
}

resource "cloudflare_record" "ucall_landingpage" {
    name = "ucall"
    value = "${var.APP_NAME_LANDING_PAGE}.herokuapp.com"
    zone_id = var.CLOUDFLARE_ETRONRESEARCH_WORK_ZONE_ID
    type = "CNAME"
    proxied = true
}

resource "cloudflare_record" "ucall_app" {
    name = "ucall-app"
    value = "${var.APP_NAME_APP}.herokuapp.com"
    zone_id = var.CLOUDFLARE_ETRONRESEARCH_WORK_ZONE_ID
    type = "CNAME"
    proxied = true
}