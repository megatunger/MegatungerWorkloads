terraform {
  backend "s3" {
    bucket = "megatunger-workloads"
    key = ".terraform/terraform.tfstate"
    region = "ap-southeast-1"
  }
}