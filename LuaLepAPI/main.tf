terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "3.0.0"
    }
  }
}

module "variables" {
  source = "../../"
}

provider "heroku" {
  email = module.variables.HEROKU_ACCOUNT_EMAIL
  api_key = module.variables.HEROKU_API_KEY
}
