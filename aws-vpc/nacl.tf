# Network Access Control List
resource "aws_network_acl" "terra_vpc_nacl" {
  vpc_id = aws_vpc.terra_vpc.id

  # allow ingress port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.DESTINATION_CIDR_BLOCK
    from_port  = 22
    to_port    = 22
  }

  # allow ingress port 80 
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.DESTINATION_CIDR_BLOCK
    from_port  = 80
    to_port    = 80
  }

  # allow egress port 22 
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.DESTINATION_CIDR_BLOCK
    from_port  = 22
    to_port    = 22
  }

  # allow egress port 80 
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.DESTINATION_CIDR_BLOCK
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "TerraformVPC NACL"
  }
}
