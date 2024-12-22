# AWS Security Configuration with Terraform

This project demonstrates the configuration of AWS Security Groups and Network ACLs (NACLs) using Terraform.

## Project Structure
aws-security-config/
├── modules/
│   ├── vpc/
│   ├── security/
│   └── compute/
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars

## Prerequisites

- AWS CLI configured
- Terraform installed (version >= 1.0.0)
- AWS account with appropriate permissions

## Components

1. VPC and Subnet Configuration
   - New VPC creation
   - Public subnet setup

2. Network ACL Configuration
   - Custom NACL creation
   - Inbound/outbound rules management
   - Subnet association

3. Security Group Configuration
   - Custom security group creation
   - Dynamic rule management

4. EC2 Instance
   - Linux instance deployment
   - Public IP assignment
   - Security group association

## Usage

1. Initialize Terraform:
   
   terraform init
   
