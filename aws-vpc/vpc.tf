# VPC
resource "aws_vpc" "terra_vpc" {
  cidr_block                       = var.VPC_CIDR
  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = "false"
  enable_classiclink               = "false"
  # enable_dns_support = "true"
  # enable_dns_hostnames = "true"

  tags = {
    Name        = "Terraform VPC"
    Environment = var.ENVIRONMENT_TAG
  }
}

# Internet Gateway - Attach it to the VPC
resource "aws_internet_gateway" "terra_igw" {
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name        = "Terraform VPC IGW"
    Environment = var.ENVIRONMENT_TAG
  }
}

# Public Subnets
resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.terra_vpc.id
  count                   = length(var.PUBLIC_SUBNETS_CIDR)
  cidr_block              = element(var.PUBLIC_SUBNETS_CIDR, count.index)
  availability_zone       = element(var.SUBNETS_AZ, count.index)
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Web Public Subnet-${count.index + 1}"
  }
}

# Public Route Table - Attach internet gateway
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.terra_vpc.id
  route {
    cidr_block = var.DESTINATION_CIDR_BLOCK
    gateway_id = aws_internet_gateway.terra_igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Public Route Table Associations - Attach route table with public subnets
resource "aws_route_table_association" "public_rt_a" {
  count          = length(var.PUBLIC_SUBNETS_CIDR)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

# Private Subnets
resource "aws_subnet" "private_subnets" {
  vpc_id                  = aws_vpc.terra_vpc.id
  count                   = length(var.PRIVATE_SUBNETS_CIDR)
  cidr_block              = element(var.PRIVATE_SUBNETS_CIDR, count.index)
  availability_zone       = element(var.SUBNETS_AZ, count.index)
  map_public_ip_on_launch = "false"

  tags = {
    Name = "Database Private Subnet-${count.index + 1}"
  }
}

# Private Route Table - Attach internet gateway
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.terra_vpc.id
  route {
    cidr_block = var.DESTINATION_CIDR_BLOCK
  }

  tags = {
    Name = "Private Route Table"
  }
}

# Private Route Table Associations - Attach route table with public subnets
resource "aws_route_table_association" "private_rt_a" {
  count          = length(var.PRIVATE_SUBNETS_CIDR)
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}
