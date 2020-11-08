terraform {
  backend "s3" {
    bucket = "megatunger-workloads"
    key = ""
    region = "ap-southeast-1"
  }
}