variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "cand-c3"
}

variable "your_name" {
  description = "Your name to be used in resource naming"
  type        = string
}
