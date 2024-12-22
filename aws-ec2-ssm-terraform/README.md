# AWS EC2 Instance with Systems Manager Access using Terraform

This project demonstrates how to securely connect to an AWS EC2 instance using AWS Systems Manager Session Manager, eliminating the need for SSH keys or password management.

## Prerequisites

- AWS CLI configured
- Terraform installed
- IAM permissions to create EC2 instances and IAM roles

## Project Structure
aws-ec2-ssm-terraform/
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
└── providers.tf

## Features

- EC2 instance deployment with Amazon Linux 2
- IAM role configuration for Systems Manager access
- Security group setup
- Systems Manager Session Manager integration

## Implementation Steps

1. EC2 Instance Launch
   - Creates an EC2 instance with Amazon Linux 2 AMI
   - Configures instance name and tags
   - Sets up security group

2. IAM Configuration
   - Creates IAM role for EC2
   - Attaches AWSSystemsManagerManagedInstanceCore policy
   - Associates role with EC2 instance

3. Security
   - Implements security group rules
   - Enables Systems Manager Session Manager access

## Usage

1. Initialize Terraform:
terraform plan
