
provider "aws" {
  region  = var.region
  version = "3.7.0"
}

terraform {
  backend "s3" {
    encrypt = true
  }
}

//module "bridgecrew-read-only" {
//  source  = "bridgecrewio/bridgecrew-read-only/aws"
//  version = "1.0.1"
//  # insert the 2 required variables here
//
//  aws_profile = "sa"
//  org_name = "bchowdypartner"
//}
