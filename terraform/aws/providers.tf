
provider "aws" {
  profile = var.profile
  region  = var.region
  version = "3.7.0"
}

terraform {
  backend "s3" {
    encrypt = true
  }
}

