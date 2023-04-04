resource "aws_route_table" "rt1" {

  tags = {
    asknowID  = "123"
    atc       = "123"
    sa_id     = "123"
    os        = "rhel"
    yor_trace = "b9f321bf-c487-47f1-8caa-0e18a7f9b437"
  }
}

resource "aws_route_table" "rt2" {

  tags = {
    atc       = "123"
    sa_id     = "123"
    os        = "rhel"
    yor_trace = "ab2dd6ca-5822-4c8d-ac6b-37b0f1ea0371"
  }
}

resource "aws_s3_bucket" "b1" {
  bucket = "b1"
  tags = {
    asknowID  = "123"
    atc       = "123"
    sa_id     = "123"
    os        = "rhel"
    yor_trace = "2b22b75f-582c-4c4c-86f6-a35942b56f73"
  }
}

resource "aws_s3_bucket" "b2" {
  bucket = "b2"
  tags = {
    asknowID  = "123"
    atc       = "123"
    sa_id     = "123"
    yor_trace = "c075ed5c-8ab5-4c57-a308-2ebfcb8a143b"
  }
}

resource "aws_instance" "i1" {
  name = "i1"
  tags = {
    asknowID  = "123"
    atc       = "123"
    sa_id     = "123"
    os        = "windows"
    yor_trace = "e4b2aad7-173d-49a3-9ac4-c785d50da25a"
  }
}

resource "aws_instance" "i2" {
  name = "i2"
  tags = {
    asknowID  = "123"
    atc       = "123"
    os        = "rhel"
    yor_trace = "b5088e4a-e8ae-4998-b8e3-a76fffd4f2ec"
  }
}

resource "aws_instance" "i3" {
  name = "i3"
  tags = {
    asknowID  = "123"
    atc       = "123"
    sa_id     = "123"
    os        = "xyz"
    yor_trace = "c33bf954-573a-4be8-8884-396b4efb29b4"
  }
}

resource "aws_instance" "i4" {
  name = "i4"
  tags = {
    asknowID  = "123"
    atc       = "123"
    sa_id     = "123"
    yor_trace = "5beaae75-1c14-43eb-aad9-e5f38b2c6560"
  }
}

resource "aws_vpc" "v2" {
  name = "v2"
  tags = {
    asknowID  = "123"
    atc       = "123"
    sa_id     = "123"
    yor_trace = "027372f8-48c3-4a81-a93b-591b7c626cf8"
  }
}

