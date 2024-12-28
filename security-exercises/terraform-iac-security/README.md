# Infrastructure as Code Security Check Exercise

This project demonstrates how to check Terraform configurations for security vulnerabilities using Regula.

## Prerequisites

- Terraform installed locally
- OPA (Open Policy Agent) installed
- AWS CLI configured with valid credentials
- Regula tool cloned locally

## Project Structure
terraform-iac-security/
 ├── .gitignore
  ├── README.md
   └── iam_policy.tf

## Setup Instructions

1. Clone this repository
2. Ensure AWS credentials are configured
3. Clone Regula tool locally
4. Run vulnerability checks using Regula

## Running Security Checks

To run the security check:


./bin/regula /path/to/this/directory lib rules/aws/

