terraform {
  backend "s3" {
    bucket = "05042024hello"
    key = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}