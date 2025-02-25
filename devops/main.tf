terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.16"
        }
    }
}

resource "aws_s3_bucket" "building" {
    bucket = "terraform-s3-bucket-building"
}

resource "aws_s3_bucket_versioning" "version" {
    bucket = aws_s3_bucket.building.id
    versioning_configuration {
        status = "Enabled"
    }
}