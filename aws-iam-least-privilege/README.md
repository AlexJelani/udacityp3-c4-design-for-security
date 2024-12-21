# AWS IAM Least Privilege Access Exercise

This Terraform project implements least privilege access control for S3 buckets using IAM roles and policies.

## Project Structure
aws-iam-least-privilege/
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars

## Requirements
- AWS CLI configured
- Terraform installed
- AWS account with appropriate permissions

## Resources Created
1. Two S3 buckets:
   - Application bucket (cand-c3-s3-app1-[yourname])
   - Off-limits bucket (cand-c3-s3-offlimits-[yourname])
2. IAM Policy (cand-c3-iam-policy-least-priv)
3. IAM Role attachment

## Features
- Allows upload/download/list operations on the application bucket
- Lists all S3 buckets
- Explicitly denies access to other buckets
- Demonstrates policy precedence with explicit deny

## Usage
1. Clone the repository
2. Update terraform.tfvars with your specific values
3. Initialize Terraform:
   
   terraform init
   
