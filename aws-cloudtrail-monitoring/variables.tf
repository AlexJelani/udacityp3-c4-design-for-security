variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket for CloudTrail logs"
  type        = string
  default     = "cloudtrail-audit-logs-demo-2024"
}

variable "trail_name" {
  description = "Name of the CloudTrail trail"
  type        = string
  default     = "main-audit-trail"
}
