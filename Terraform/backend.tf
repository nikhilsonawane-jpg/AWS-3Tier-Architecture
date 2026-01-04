resource "aws_s3_bucket" "terraform_state" {
  bucket = "nikhil-terraform-3tier-state"

  tags = {
    Name = "terraform-state-bucket"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


# terraform {
#   backend "s3" {
#     bucket         = "nikhil-terraform-3tier-state"
#     key            = "3tier/terraform.tfstate"
#     region         = "ap-south-1"
#     dynamodb_table = "terraform-state-locks"
#     encrypt        = true
#   }
# }
