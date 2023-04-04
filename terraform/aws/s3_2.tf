resource "aws_s3_bucket" "logs" {
  # bridgecrew:skip=BC_AWS_S3_16:test
  bucket        = "${local.resource_prefix.value}-logs"
  acl           = "log-delivery-write"
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-logs"
    Environment = local.resource_prefix.value
    yor_trace   = "2ddb5d04-f2c7-4d8a-bd88-30f2a0f309f7"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
