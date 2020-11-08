terraform {
  backend "s3" {
    bucket = "megatunger-workloads"
    key = ".terraform/terraform.tfstate"
    region = "ap-southeast-1"
  }

  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "3.0.0"
    }
  }
}

provider "heroku" {
    email = var.HEROKU_ACCOUNT_EMAIL
    api_key = var.HEROKU_API_KEY
}

module "LuaLepAPI" {
  source = "./LuaLepAPI"

  HEROKU_ACCOUNT_EMAIL = var.HEROKU_ACCOUNT_EMAIL
  HEROKU_API_KEY = var.HEROKU_API_KEY
}