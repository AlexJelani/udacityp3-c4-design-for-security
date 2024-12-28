# AWS Config Monitoring with Terraform

This project sets up AWS Config to monitor S3 bucket configurations and identify potential misconfigurations.

## Prerequisites

- AWS CLI configured
- Terraform installed
- AWS account with appropriate permissions

## Resources Created

- AWS Config Recorder
- AWS Config Recording Status
- S3 Bucket for AWS Config logs
- AWS Config Rule for S3 bucket versioning
- IAM Role for AWS Config

## Usage

1. Initialize Terraform:
 init

2. Review the planned changes:
 plan

3. Apply the configuration:
 apply

## Configuration Details

This setup includes:
- AWS Config recorder configuration
- S3 bucket versioning monitoring rule
- Necessary IAM roles and policies

## Cleanup

To remove all resources created by this project:
 destroy

## Architecture

The solution implements:
- AWS Config recording for S3 bucket resources
- Automated compliance checking for bucket versioning
- Compliance history tracking

## Security Considerations

- AWS Config logs are stored in a dedicated S3 bucket
- IAM roles follow principle of least privilege
- All resources are monitored for compliance
