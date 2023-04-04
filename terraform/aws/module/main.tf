variable "acl" {
  type    = string
  default = "public-read"
}

variable "versioning" {
  type = bool
}


resource "aws_s3_bucket" "module-bucket" {
  bucket        = "module-bucket"
  acl           = var.acl
  force_destroy = true

  versioning {
    enabled = var.versioning
  }
  tags = {
    yor_trace = "880bd623-2922-4275-b637-d7ba859b7c9f"
  }
}