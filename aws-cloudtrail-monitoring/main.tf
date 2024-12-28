# S3 Bucket for storing logs
resource "aws_s3_bucket" "trail_bucket" {
  bucket        = var.bucket_name
  force_destroy = true
}

# Enable versioning
resource "aws_s3_bucket_versioning" "trail_bucket_versioning" {
  bucket = aws_s3_bucket.trail_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 bucket policy
resource "aws_s3_bucket_policy" "trail_bucket_policy" {
  bucket = aws_s3_bucket.trail_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AWSCloudTrailAclCheck"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.trail_bucket.arn
      },
      {
        Sid    = "AWSCloudTrailWrite"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.trail_bucket.arn}/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}

# IAM Policy for CloudTrail
resource "aws_iam_policy" "cloudtrail_policy" {
  name = "cloudtrail-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudtrail:*",
          "s3:*",
          "iam:GetRole",
          "iam:CreateRole",
          "iam:PutRolePolicy"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach policy to your IAM user
resource "aws_iam_user_policy_attachment" "cloudtrail_policy_attach" {
  user       = "iamadmin"  # Your IAM username
  policy_arn = aws_iam_policy.cloudtrail_policy.arn
}
