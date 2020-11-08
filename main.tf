terraform {
  backend "s3" {
    bucket = "megatunger-workloads"
    key = ".terraform/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

module "variables" {
  source = "../"
}

module "LuaLepAPI" {
  source = "./LuaLepAPI"

  HEROKU_ACCOUNT_EMAIL = module.variables.HEROKU_ACCOUNT_EMAIL
  HEROKU_API_KEY = module.variables.HEROKU_API_KEY
}