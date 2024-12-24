# AWS KMS Key for S3 Bucket Encryption

This Terraform configuration creates an AWS KMS key and configures it as the default encryption key for an S3 bucket.

## Components

- AWS KMS key with alias
- S3 bucket with KMS encryption
- IAM policies for key usage

## Prerequisites

- AWS CLI configured
- Terraform installed
- Appropriate AWS permissions

## Usage

1. Initialize Terraform:
```bash
terraform init
