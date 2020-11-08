terraform {
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
