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
}

resource "aws_s3_bucket" "b2" {
  bucket = "b2"
  tags = {
    asknowID = "123"
    atc = "123"
    sa_id = "123"
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
  name = "i1"
  tags = {
    asknowID = "123"
    atc = "123"
    os = "rhel"
  }
}
