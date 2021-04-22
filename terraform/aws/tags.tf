resource "aws_route_table" "rt1" {

  tags = {
    asknowID = "123"
    atc = "123"
    sa_id = "123"
    os = "rhel"
  }
}

resource "aws_route_table" "rt2" {

  tags = {
    atc = "123"
    sa_id = "123"
    os = "rhel"
  }
}

resource "aws_s3_bucket" "b1" {
  bucket = "b1"
  tags = {
    asknowID = "123"
    atc = "123"
    sa_id = "123"
    os = "rhel"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "b2" {
  bucket = "b2"
  tags = {
    asknowID = "123"
    atc = "123"
    sa_id = "123"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_instance" "i1" {
  name = "i1"
  tags = {
    asknowID = "123"
    atc = "123"
    sa_id = "123"
    os = "windows"
  }
}

resource "aws_instance" "i2" {
  name = "i2"
  tags = {
    asknowID = "123"
    atc = "123"
    os = "rhel"
  }
}

resource "aws_instance" "i3" {
  name = "i3"
  tags = {
    asknowID = "123"
    atc = "123"
    sa_id = "123"
    os = "xyz"
  }
}

resource "aws_instance" "i4" {
  name = "i4"
  tags = {
    asknowID = "123"
    atc = "123"
    sa_id = "123"
  }
}

resource "aws_vpc" "v2" {
  name = "v2"
  tags = {
    asknowID = "123"
    atc = "123"
    sa_id = "123"
  }
}

