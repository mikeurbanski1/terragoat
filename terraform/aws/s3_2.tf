resource "aws_s3_bucket" "logs" {
  # bridgecrew:skip=BC_AWS_S3_16:test
  bucket = "${local.resource_prefix.value}-logs"
  acl = "log-delivery-write"
  force_destroy = true
  tags = {
    Name = "${local.resource_prefix.value}-logs"
    Environment = local.resource_prefix.value
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
