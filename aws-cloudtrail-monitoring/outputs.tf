# output "cloudtrail_arn" {
#   description = "ARN of the CloudTrail trail"
#   value       = aws_cloudtrail.main_trail.arn
# }

output "s3_bucket_name" {
  description = "Name of the S3 bucket storing CloudTrail logs"
  value       = aws_s3_bucket.trail_bucket.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket storing CloudTrail logs"
  value       = aws_s3_bucket.trail_bucket.arn
}