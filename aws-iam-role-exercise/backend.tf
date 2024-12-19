
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-079536516580-us-east-1-v2"
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# After the bucket is created, you can uncomment this backend configuration
# terraform {
#   backend "s3" {
#     bucket = "terraform-state-079536516580-us-east-1"
#     key    = "iam-role-exercise/terraform.tfstate"
#     region = "us-east-1"
#   }
# }
