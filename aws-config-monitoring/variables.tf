variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "config_bucket_prefix" {
  description = "Prefix for the S3 bucket that will store AWS Config data"
  type        = string
  default     = "aws-config-bucket"
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "dev"
}
