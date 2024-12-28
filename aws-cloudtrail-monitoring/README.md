# AWS CloudTrail Monitoring with Terraform

This project implements AWS CloudTrail monitoring and S3 bucket management using Terraform.

## Prerequisites

- AWS Account
- Terraform installed
- AWS CLI configured

## Project Structure
aws-cloudtrail-monitoring/
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
└── README.md

## Features

- Creates S3 bucket with versioning
- Configures CloudTrail for monitoring
- Enables tracking of:
  - Console logins
  - S3 bucket operations
  - Versioning changes

## Usage

1. Initialize Terraform:

terraform init

