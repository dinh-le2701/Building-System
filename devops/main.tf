terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

data "aws_s3_bucket" "existing" {
  bucket = "terraform-s3-bucket-building"
}

resource "aws_s3_bucket" "building" {
  bucket = "terraform-s3-bucket-building"

  lifecycle {
    prevent_destroy = true
  }

  # Chỉ tạo nếu bucket chưa tồn tại
  count = length(data.aws_s3_bucket.existing.id) == 0 ? 1 : 0
}

locals {
  bucket_id = length(aws_s3_bucket.building) > 0 ? aws_s3_bucket.building[0].id : data.aws_s3_bucket.existing.id
}


resource "aws_s3_bucket_versioning" "version" {
  bucket = local.bucket_id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = local.bucket_id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
