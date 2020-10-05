
data "aws_caller_identity" "current" {}

variable "company_name" {
  default = "hello"
}

variable "environment" {
  default = "hello"
}

locals {
  resource_prefix = {
    value = "${data.aws_caller_identity.current.account_id}-${var.company_name}-${var.environment}"
  }
}

variable "region" {
  default = "us-west-2"
}

variable "availability_zone" {
  type    = "string"
  default = "us-west-2a"
}

variable "availability_zone2" {
  type    = "string"
  default = "us-west-2b"
}

variable ami {
  type    = "string"
  default = "ami-09a5b0b7edf08843d"
}

variable "dbname" {
  type        = "string"
  description = "Name of the Database"
  default     = "db1"
}

variable "password" {
  type        = "string"
  description = "Database password"
  default     = "Aa1234321Bb"
}
