terraform {
  backend "s3" {
    bucket         = "terraform-s3-bucket-building"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}
