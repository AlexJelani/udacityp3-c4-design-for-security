resource "aws_network_acl" "main" {
  vpc_id = var.vpc_id

  ingress {
    protocol   = "icmp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "main-nacl"
  }
}

resource "aws_network_acl_association" "main" {
  network_acl_id = aws_network_acl.main.id
  subnet_id      = var.subnet_id
}
resource "aws_security_group" "main" {
  name        = "main-sg"
  description = "Security group for EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
    description = "SSH access"
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.allowed_cidr]
    description = "PING access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main-sg"
  }
}