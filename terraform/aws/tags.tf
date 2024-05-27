resource "aws_route_table" "rt1" {

  tags = {
    asknowID = "123"
    atc      = "123"
    sa_id    = "123"
    os       = "rhel"
    try      = ""
  }
}

resource "aws_route_table" "rt2" {

  tags = {
    atc   = "123"
    sa_id = "123"
    os    = "rhel"
    try   = ""
  }
}

resource "aws_s3_bucket" "b1" {
  bucket = "b1"
  tags = {
    asknowID = "123"
    atc      = "123"
    sa_id    = "123"
    os       = "rhel"
    try      = ""
  }
}

resource "aws_s3_bucket" "b2" {
  bucket = "b2"
  tags = {
    asknowID = "123"
    atc      = "123"
    sa_id    = "123"
    try      = ""
  }
}

resource "aws_instance" "i1" {
  name = "i1"
  tags = {
    asknowID = "123"
    atc      = "123"
    sa_id    = "123"
    os       = "windows"
    try      = ""
  }
}

resource "aws_instance" "i2" {
  name = "i2"
  tags = {
    asknowID = "123"
    atc      = "123"
    os       = "rhel"
    try      = ""
  }
}

resource "aws_instance" "i3" {
  name = "i3"
  tags = {
    asknowID = "123"
    atc      = "123"
    sa_id    = "123"
    os       = "xyz"
    try      = ""
  }
}

resource "aws_instance" "i4" {
  name = "i4"
  tags = {
    asknowID = "123"
    atc      = "123"
    sa_id    = "123"
    try      = ""
  }
}

resource "aws_vpc" "v2" {
  name = "v2"
  tags = {
    asknowID = "123"
    atc      = "123"
    sa_id    = "123"
    try      = ""
  }
}

