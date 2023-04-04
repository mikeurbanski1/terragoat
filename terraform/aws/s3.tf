module "m1" {
  source     = "./module"
  versioning = true
}

module "m2" {
  source     = "./module"
  versioning = false
}

module "m3" {
  source     = "./module"
  versioning = false
  acl        = "private"
}

resource "aws_s3_bucket" "data999" {
  # checkov:skip=BC_AWS_S3_1:not needed
  bucket        = "${local.resource_prefix.value}-data"
  acl           = "public-read"
  force_destroy = true
  tags = {
    Owner       = "data-team"
    Environment = local.resource_prefix.value
    yor_trace   = "6e50d522-b672-455e-a35f-af14a3805112"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "data1234" {
  bucket        = "${local.resource_prefix.value}-data"
  acl           = "public-read"
  force_destroy = true
  tags = {
    Owner       = "data-team"
    Environment = local.resource_prefix.value
    yor_trace   = "8c3d745f-d27a-4d8c-805f-53e919394982"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "data" {
  bucket        = "${local.resource_prefix.value}-data"
  acl           = "public-read"
  force_destroy = true
  tags = {
    Owner       = "data-team"
    Environment = local.resource_prefix.value
    yor_trace   = "12e4464c-f131-4ea1-848f-5bca3e81b511"
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
  acl    = "private"
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
  tags = {
    yor_trace = "8b82c719-d836-41bc-92a7-855cdd6c11e1"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "${local.resource_prefix.value}-logs"
  acl    = "log-delivery-write"
  versioning {
    enabled = true
  }
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-logs"
    Environment = local.resource_prefix.value
    yor_trace   = "f2e1a292-6eeb-41d9-b4ed-6d9f9b8b39fa"
  }
}

resource "aws_kms_key" "s3_kms" {

  tags = {
    yor_trace = "886cd523-4aa8-4c3b-8352-530a701b3dc8"
  }
}

resource "aws_s3_bucket" "conf1" {
  bucket        = "bc-confidential-1"
  force_destroy = true
  tags = {
    DataClassification = "Confidential"
    yor_trace          = "2a291117-07e7-4771-9898-869609f50838"
  }
}

resource "aws_s3_bucket" "conf2" {
  bucket        = "bc-confidential-2"
  force_destroy = true
  tags = {
    DataClassification = "Confidential"
    yor_trace          = "2a0c0949-4708-43b0-b74a-4520719baf5e"
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
  bucket        = "bc-confidential-3"
  force_destroy = true
  tags = {
    DataClassification = "Confidential"
    yor_trace          = "27857e13-c299-4974-83fe-6df885fb80d5"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.s3_kms.arn
      }
    }
  }
}

resource "aws_s3_bucket" "conf4" {
  bucket        = "bc-confidential-4"
  force_destroy = true
  tags = {
    DataClassification = "Highly confidential"
    yor_trace          = "74d33f74-a8d6-49eb-8301-4f35c5079955"
  }
}

resource "aws_s3_bucket" "conf5" {
  bucket        = "bc-confidential-5"
  force_destroy = true
  tags = {
    DataClassification = "Highly confidential"
    yor_trace          = "d9aff649-63f6-4777-8d2d-655341fa22b5"
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
  bucket        = "bc-confidential-6"
  force_destroy = true
  tags = {
    DataClassification = "Highly confidential"
    yor_trace          = "8834b16e-19aa-45fb-98dc-882a058e756b"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.s3_kms.arn
      }
    }
  }
}

resource "aws_s3_bucket" "conf7" {
  bucket        = "bc-confidential-6"
  force_destroy = true
  tags = {
    DataClassification = "Public"
    yor_trace          = "80a9bbe6-0a48-41e4-a15a-a139a3714bee"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
