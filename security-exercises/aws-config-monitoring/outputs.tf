output "config_bucket_name" {
  description = "Name of the S3 bucket storing AWS Config data"
  value       = aws_s3_bucket.config.id
}

output "config_rule_arn" {
  description = "ARN of the AWS Config rule"
  value       = aws_config_config_rule.s3_bucket_versioning.arn
}
