provider "aws" {
  region = "us-east-1"
}

# Create IAM User
resource "aws_iam_user" "user" {
  name = "cand-c3-iam-user"
}

# Create login profile for console access with a direct password
resource "aws_iam_user_login_profile" "user_login" {
  user                    = aws_iam_user.user.name
  password_length         = 16
  password_reset_required = true
}
# Create IAM policy for the user
resource "aws_iam_policy" "user_policy" {
  name = "cand-c3-iam-user-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Resource = "arn:aws:iam::079536516580:role/cand-c3-iam-role"
    }]
  })
}
# Attach policy to user
resource "aws_iam_user_policy_attachment" "user_policy_attach" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.user_policy.arn
}
# Create IAM role
resource "aws_iam_role" "role" {
  name = "cand-c3-iam-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_user.user.arn
        }
        Action = "sts:AssumeRole"
        Condition = {
          Bool = {
            "aws:MultiFactorAuthPresent": "true"
          }
        }
      }
    ]
  })
}
# Attach S3 read-only access to role
resource "aws_iam_role_policy_attachment" "role_policy" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}