provider "aws" {
  region = "us-east-1"
  access_key = "AKIARQUZ5F7ZU3WKDBCX"
  secret_key = "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"
}

resource "aws_s3_bucket" "mybucket1" {
bucket = "shivi-08-13"
tags = {
ProjectName = "Bucket1"
Environment = "Development"
}
}

resource "aws_s3_bucket_acl" "mybucket1ACL" {
acl = "private"
bucket = aws_s3_bucket.mybucket1.id
}

resource "aws_s3_bucket_object" "myobject1" {
bucket = aws_s3_bucket.mybucket1.id
key = "testobject"
source = "mytraining.txt"
acl = "private"
}

