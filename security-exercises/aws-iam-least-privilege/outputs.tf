output "app_bucket_name" {
  description = "Name of the application S3 bucket"
  value       = aws_s3_bucket.app_bucket.id
}

output "offlimits_bucket_name" {
  description = "Name of the off-limits S3 bucket"
  value       = aws_s3_bucket.offlimits_bucket.id
}

output "policy_arn" {
  description = "ARN of the created IAM policy"
  value       = aws_iam_policy.least_privilege_policy.arn
}

output "role_arn" {
  description = "ARN of the existing IAM role"
  value       = data.aws_iam_role.existing_role.arn
}
