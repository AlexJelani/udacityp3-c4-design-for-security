provider "aws" {
  region = var.aws_region
}

# S3 Buckets
resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.name_prefix}-s3-app1-${var.your_name}"
}

resource "aws_s3_bucket" "offlimits_bucket" {
  bucket = "${var.name_prefix}-s3-offlimits-${var.your_name}"
}

# IAM Policy
resource "aws_iam_policy" "least_privilege_policy" {
  name        = "${var.name_prefix}-iam-policy-least-priv"
  description = "Least privilege access policy for S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowSpecificBucketAccess"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.app_bucket.arn,
          "${aws_s3_bucket.app_bucket.arn}/*"
        ]
      },
      {
        Sid    = "AllowListAllBuckets"
        Effect = "Allow"
        Action = ["s3:ListAllBuckets"]
        Resource = ["*"]
      },
      {
        Sid    = "DenyOtherBuckets"
        Effect = "Deny"
        Action = ["s3:GetObject"]
        Resource = [
          "arn:aws:s3:::*/*"
        ]
        Condition = {
          StringNotEquals = {
            "s3:ResourceAccount": [data.aws_caller_identity.current.account_id]
          }
        }
      }
    ]
  })
}

# Get existing IAM role
data "aws_iam_role" "existing_role" {
  name = "${var.name_prefix}-iam-role"
}

# Current AWS account ID
data "aws_caller_identity" "current" {}

# Attach custom policy to role
resource "aws_iam_role_policy_attachment" "custom_policy_attachment" {
  role       = data.aws_iam_role.existing_role.name
  policy_arn = aws_iam_policy.least_privilege_policy.arn
}

# Attach S3 full access managed policy
resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = data.aws_iam_role.existing_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
