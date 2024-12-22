
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
}

variable "allowed_cidr" {
  description = "CIDR block for allowed IP"
  type        = string
}
