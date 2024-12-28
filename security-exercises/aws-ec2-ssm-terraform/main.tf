# IAM role for EC2 Systems Manager
resource "aws_iam_role" "ssm_role" {
  name = "ec2_ssm_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}
# Attach SSM policy to role
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
# Create instance profile
resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ssm_profile"
  role = aws_iam_role.ssm_role.name
}
# Security group
resource "aws_security_group" "instance_sg" {
  name        = "ssm-instance-sg"
  description = "Security group for SSM managed instance"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.default.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssm-instance-sg"
  }
}
# Data source for latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
# Add this at the beginning of your main.tf
data "aws_subnet" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  availability_zone = "${var.aws_region}a"
}

# EC2 Instance
resource "aws_instance" "ssm_instance" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  subnet_id              = data.aws_subnet.selected.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y amazon-ssm-agent
              systemctl enable amazon-ssm-agent
              systemctl start amazon-ssm-agent
              EOF

  tags = {
    Name = var.instance_name
  }
}
# Add public subnet for internet access
resource "aws_subnet" "main" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.96.0/20"  # Use a CIDR that doesn't conflict with existing subnets

  tags = {
    Name = "ssm-subnet"
  }
}
# Get existing Internet Gateway
data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
# Update route table
resource "aws_route_table" "main" {
  vpc_id = data.aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.default.id
  }

  tags = {
    Name = "ssm-route-table"
  }
}
# Associate route table with subnet
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Create VPC endpoints for SSM connectivity
resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = data.aws_vpc.default.id
  service_name        = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.instance_sg.id]
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = data.aws_vpc.default.id
  service_name        = "com.amazonaws.${var.aws_region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.instance_sg.id]
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = data.aws_vpc.default.id
  service_name        = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.instance_sg.id]
}
