#####################################

## HEROKU VARIABLES ##

variable "HEROKU_ACCOUNT_EMAIL" {
    default = "megatunger@gmail.com"
}
variable "HEROKU_API_KEY" {}

#####################################

## CLOUDFLARE VARIABLES ##

variable "CLOUDFLARE_ACCOUNT_EMAIL" {
    default = "megatunger@gmail.com"
}
variable "CLOUDFLARE_API_KEY" {}
variable "CLOUDFLARE_MEGATUNGER_COM_ZONE_ID" {}

#####################################


terraform {
  backend "s3" {
    bucket = "megatunger-workloads"
    key = ".terraform/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

module "LuaLepAPI" {
  source = "./LuaLepAPI"

  HEROKU_ACCOUNT_EMAIL = var.HEROKU_ACCOUNT_EMAIL
  HEROKU_API_KEY = var.HEROKU_API_KEY
  CLOUDFLARE_ACCOUNT_EMAIL = var.CLOUDFLARE_ACCOUNT_EMAIL
  CLOUDFLARE_API_KEY = var.CLOUDFLARE_API_KEY
  CLOUDFLARE_MEGATUNGER_COM_ZONE_ID = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
}

module "TestReady" {
  source = "./TestReady"

  HEROKU_ACCOUNT_EMAIL = var.HEROKU_ACCOUNT_EMAIL
  HEROKU_API_KEY = var.HEROKU_API_KEY
  CLOUDFLARE_ACCOUNT_EMAIL = var.CLOUDFLARE_ACCOUNT_EMAIL
  CLOUDFLARE_API_KEY = var.CLOUDFLARE_API_KEY
  CLOUDFLARE_MEGATUNGER_COM_ZONE_ID = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
}