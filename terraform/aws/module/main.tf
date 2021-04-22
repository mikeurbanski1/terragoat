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
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}