# AWS S3 Least Privilege Policy

This Terraform configuration creates a least-privileged IAM policy that allows read-only access to a specific S3 bucket.

## Features

- Creates an IAM policy that only allows GetObject operations
- Restricts access to a single specified S3 bucket
- Follows AWS security best practices for least privilege access

## Prerequisites

- AWS CLI configured
- Terraform installed
- AWS credentials with appropriate permissions

## Usage

1. Update the `variables.tf` file with your S3 bucket name
2. Initialize Terraform:
   ```bash
   terraform init
