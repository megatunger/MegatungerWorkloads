terraform {
  backend "s3" {
    bucket = "megatunger-workloads"
    region = "ap-southeast-1"
  }
}