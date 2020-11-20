resource "aws_s3_bucket" "data" {
  bucket = "${local.resource_prefix.value}-data"
  acl = "public-read"
  force_destroy = true
  tags = {
    Owner = "data-team"
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

resource "aws_s3_bucket" "data_science" {
  bucket = "${local.resource_prefix.value}-data-science"
  acl = "private"
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "log/"
  }
  force_destroy = true
}

resource "aws_s3_bucket" "logs" {
  bucket = "${local.resource_prefix.value}-logs"
  acl = "log-delivery-write"
  versioning {
    enabled = true
  }
  force_destroy = true
  tags = {
    Name = "${local.resource_prefix.value}-logs"
    Environment = local.resource_prefix.value
  }
}

resource "aws_kms_key" "s3_kms" {

}

resource "aws_s3_bucket" "conf1" {
  bucket = "bc-confidential-1"
  force_destroy = true
  tags = {
    DataClassification = "Confidential"
  }
}

resource "aws_s3_bucket" "conf2" {
  bucket = "bc-confidential-2"
  force_destroy = true
  tags = {
    DataClassification = "Confidential"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "conf3" {
  bucket = "bc-confidential-3"
  force_destroy = true
  tags = {
    DataClassification = "Confidential"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
        kms_master_key_id = aws_kms_key.s3_kms.arn
      }
    }
  }
}

resource "aws_s3_bucket" "conf4" {
  bucket = "bc-confidential-4"
  force_destroy = true
}

resource "aws_s3_bucket" "conf5" {
  bucket = "bc-confidential-5"
  force_destroy = true
  tags = {
    DataClassification = "Highly confidential"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "conf6" {
  bucket = "bc-confidential-6"
  force_destroy = true
  tags = {
    DataClassification = "Highly confidential"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
        kms_master_key_id = aws_kms_key.s3_kms.arn
      }
    }
  }
}

resource "aws_s3_bucket" "conf7" {
  bucket = "bc-confidential-6"
  force_destroy = true
  tags = {
    DataClassification = "Public"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
