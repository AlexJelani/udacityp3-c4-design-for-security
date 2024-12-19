output "password" {
  value = aws_iam_user_login_profile.user_login.password
  description = "The password for the IAM user"
  sensitive = true
}

output "account_id" {
  value = "235211541647"
  description = "AWS Account ID"
}
