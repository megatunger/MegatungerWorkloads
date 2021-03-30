#####################################

## HEROKU VARIABLES ##

variable "HEROKU_ACCOUNT_EMAIL" {
    default = "megatunger@gmail.com"
}
variable "HEROKU_API_KEY" {}
variable "HEROKU_ACCOUNT_MEGATUNGER_API_KEY" {}

#####################################

## CLOUDFLARE VARIABLES ##

variable "CLOUDFLARE_ACCOUNT_EMAIL" {
    default = "megatunger@gmail.com"
}
variable "CLOUDFLARE_API_KEY" {}
variable "CLOUDFLARE_MEGATUNGER_COM_ZONE_ID" {}
variable "CLOUDFLARE_SOLVEX_EDU_VN_ZONE_ID" {}
variable "CLOUDFLARE_EDUMET_EDU_VN_ZONE_ID" {}
variable "CLOUDFLARE_ETRONRESEARCH_WORK_ZONE_ID" {}

#####################################

## AWS VARIABLES ##

variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_REGION" {}
variable "AWS_SECRET_ACCESS_KEY" {}

#####################################

## GITHUB VARIABLES ##

variable "GITHUB_API_TOKEN" {}

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

module "PersonalBlog" {
  source = "./PersonalBlog"

  HEROKU_ACCOUNT_EMAIL = var.HEROKU_ACCOUNT_EMAIL
  HEROKU_API_KEY = var.HEROKU_API_KEY
  CLOUDFLARE_ACCOUNT_EMAIL = var.CLOUDFLARE_ACCOUNT_EMAIL
  CLOUDFLARE_API_KEY = var.CLOUDFLARE_API_KEY
  CLOUDFLARE_MEGATUNGER_COM_ZONE_ID = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
}

module "AIAcademyLandingPage" {
  source = "./AIAcademyLandingPage"

  HEROKU_ACCOUNT_EMAIL = var.HEROKU_ACCOUNT_EMAIL
  HEROKU_ACCOUNT_MEGATUNGER_API_KEY = var.HEROKU_ACCOUNT_MEGATUNGER_API_KEY
  CLOUDFLARE_ACCOUNT_EMAIL = var.CLOUDFLARE_ACCOUNT_EMAIL
  CLOUDFLARE_API_KEY = var.HEROKU_ACCOUNT_MEGATUNGER_API_KEY
  CLOUDFLARE_MEGATUNGER_COM_ZONE_ID = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
}

module "BinhMinhIdCardAPI" {
  source = "./BinhMinhIdCardAPI"

  HEROKU_ACCOUNT_EMAIL = var.HEROKU_ACCOUNT_EMAIL
  HEROKU_API_KEY = var.HEROKU_API_KEY
  CLOUDFLARE_ACCOUNT_EMAIL = var.CLOUDFLARE_ACCOUNT_EMAIL
  CLOUDFLARE_API_KEY = var.CLOUDFLARE_API_KEY
  CLOUDFLARE_MEGATUNGER_COM_ZONE_ID = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
}

module "BinhMinhERP" {
  source = "./BinhMinhERP"

  CLOUDFLARE_ACCOUNT_EMAIL = var.CLOUDFLARE_ACCOUNT_EMAIL
  CLOUDFLARE_API_KEY = var.CLOUDFLARE_API_KEY
  CLOUDFLARE_MEGATUNGER_COM_ZONE_ID = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
}

module "SolveX" {
  source = "./SolveX"

  HEROKU_ACCOUNT_EMAIL = var.HEROKU_ACCOUNT_EMAIL
  HEROKU_ACCOUNT_MEGATUNGER_API_KEY = var.HEROKU_ACCOUNT_MEGATUNGER_API_KEY
  CLOUDFLARE_ACCOUNT_EMAIL = var.CLOUDFLARE_ACCOUNT_EMAIL
  CLOUDFLARE_API_KEY = var.CLOUDFLARE_API_KEY
  CLOUDFLARE_SOLVEX_EDU_VN_ZONE_ID = var.CLOUDFLARE_SOLVEX_EDU_VN_ZONE_ID
  GITHUB_API_TOKEN = var.GITHUB_API_TOKEN
  AWS_ACCESS_KEY_ID = var.AWS_ACCESS_KEY_ID
  AWS_BUCKET = "solve-x"
  AWS_REGION = var.AWS_REGION
  AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
}


module "EtronServiceAPI" {
  source = "./EtronServiceAPI"

  HEROKU_ACCOUNT_EMAIL = var.HEROKU_ACCOUNT_EMAIL
  HEROKU_API_KEY = var.HEROKU_API_KEY
  CLOUDFLARE_ACCOUNT_EMAIL = var.CLOUDFLARE_ACCOUNT_EMAIL
  CLOUDFLARE_API_KEY = var.CLOUDFLARE_API_KEY
  GITHUB_API_TOKEN = var.GITHUB_API_TOKEN
  CLOUDFLARE_MEGATUNGER_COM_ZONE_ID = var.CLOUDFLARE_MEGATUNGER_COM_ZONE_ID
}


module "Edumet" {
  source = "./Edumet"

  HEROKU_ACCOUNT_EMAIL = var.HEROKU_ACCOUNT_EMAIL
  HEROKU_ACCOUNT_MEGATUNGER_API_KEY = var.HEROKU_ACCOUNT_MEGATUNGER_API_KEY
  CLOUDFLARE_ACCOUNT_EMAIL = var.CLOUDFLARE_ACCOUNT_EMAIL
  CLOUDFLARE_API_KEY = var.CLOUDFLARE_API_KEY
  CLOUDFLARE_EDUMET_EDU_VN_ZONE_ID = var.CLOUDFLARE_EDUMET_EDU_VN_ZONE_ID
}



module "uCall" {
  source = "./uCall"

  HEROKU_ACCOUNT_EMAIL = var.HEROKU_ACCOUNT_EMAIL
  HEROKU_API_KEY = var.HEROKU_API_KEY
  CLOUDFLARE_ACCOUNT_EMAIL = var.CLOUDFLARE_ACCOUNT_EMAIL
  CLOUDFLARE_API_KEY = var.CLOUDFLARE_API_KEY
  CLOUDFLARE_ETRONRESEARCH_WORK_ZONE_ID = var.CLOUDFLARE_ETRONRESEARCH_WORK_ZONE_ID
  GITHUB_API_TOKEN = var.GITHUB_API_TOKEN
}