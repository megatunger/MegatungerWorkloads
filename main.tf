terraform {
  backend "s3" {
    bucket = "megatunger-workloads"
    key = "terraform"
    region = "ap-southeast-1"
  }
}