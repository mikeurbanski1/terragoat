variable "acl" {
  type = string
  default = "public-read"
}

variable "versioning" {
  type = bool
}


resource "aws_s3_bucket" "module-bucket" {
  bucket = "module-bucket"
  acl = var.acl
  force_destroy = true

  versioning {
    enabled = var.versioning
  }
}