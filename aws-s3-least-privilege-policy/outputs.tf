output "policy_arn" {
  value       = aws_iam_policy.s3_read_only.arn
  description = "ARN of the created IAM policy"
}
