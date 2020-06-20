# Define the security group for public subnet
resource "aws_security_group" "sg_web" {
  name        = "terra_vpc_web_sg"
  description = "Allow incoming HTTP connections & SSH access"
  vpc_id      = aws_vpc.terra_vpc.id

  # allow ingress of port 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.INGRESS_CIDR_BLOCK
  }

  # allow ingress of port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.INGRESS_CIDR_BLOCK
  }

  egress {
    from_port = 0
    to_port   = 0
    # -1 means ALL TRAFFIC
    protocol    = "-1"
    cidr_blocks = var.EGRESS_CIDR_BLOCK
  }

  tags = {
    Name = "Web Server SG"
  }
}


# Define the security group for private subnet
resource "aws_security_group" "sg_db" {
  name        = "terra_vpc_db_sg"
  description = "Allow traffic from private subnet"
  vpc_id      = aws_vpc.terra_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.INGRESS_CIDR_BLOCK
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.INGRESS_CIDR_BLOCK
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.INGRESS_CIDR_BLOCK
  }

  tags = {
    Name = "DB SG"
  }
}
