resource "aws_s3_bucket" "logs" {
  # bridgecrew:skip=BC_AWS_S3_16:test
  bucket = "${local.resource_prefix.value}-logs"
  acl = "log-delivery-write"
  force_destroy = true
  tags = {
    Name = "${local.resource_prefix.value}-logs"
    Environment = local.resource_prefix.value
  }
}
