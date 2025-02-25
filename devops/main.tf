terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

resource "aws_s3_bucket" "building" {
  bucket = "terraform-s3-bucket-building"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "version" {
  bucket = aws_s3_bucket.building.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.building.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
