resource "aws_s3_bucket" "mybucket1" {
bucket = "shivi-12-8-22-${terraform.workspace}"
tags = {
Name = "Bucket1-${terraform.workspace}"
}
}

