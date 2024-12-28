# S3 bucket for AWS Config logs
resource "aws_s3_bucket" "config" {
  bucket = "${var.config_bucket_prefix}-${data.aws_caller_identity.current.account_id}"

  tags = {
    Environment = var.environment
  }
}

# Enable versioning for the Config bucket
resource "aws_s3_bucket_versioning" "config" {
  bucket = aws_s3_bucket.config.id
  versioning_configuration {
    status = "Enabled"
  }
}

# IAM role for AWS Config
resource "aws_iam_role" "config" {
  name = "aws-config-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "config.amazonaws.com"
        }
      }
    ]
  })
}

# AWS Config recorder
resource "aws_config_configuration_recorder" "config" {
  name     = "config-recorder"
  role_arn = aws_iam_role.config.arn

  recording_group {
    all_supported = false
    resource_types = ["AWS::S3::Bucket"]
  }
}
# Enable Config recorder
resource "aws_config_configuration_recorder_status" "config" {
  name       = aws_config_configuration_recorder.config.name
  is_enabled = true
  
  depends_on = [aws_config_delivery_channel.config]
}
# AWS Config rule for S3 bucket versioning
resource "aws_config_config_rule" "s3_bucket_versioning" {
  name = "s3-bucket-versioning-enabled"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
  }

  depends_on = [aws_config_configuration_recorder.config]
}

# Get current AWS account ID
data "aws_caller_identity" "current" {}

# AWS Config delivery channel
resource "aws_config_delivery_channel" "config" {
  name           = "config-delivery-channel"
  s3_bucket_name = aws_s3_bucket.config.id

  depends_on = [aws_config_configuration_recorder.config]
}
