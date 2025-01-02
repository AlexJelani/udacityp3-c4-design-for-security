output "kms_key_id" {
  description = "The ID of the KMS key"
  value       = aws_kms_key.s3_key.id
}

output "kms_key_arn" {
  description = "The ARN of the KMS key"
  value       = aws_kms_key.s3_key.arn
}

output "s3_bucket_name" {
  description = "The name of the encrypted S3 bucket"
  value       = aws_s3_bucket.encrypted_bucket.id
}
