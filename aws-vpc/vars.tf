# provider.tf
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {}

# key-pair.tf
variable "PATH_TO_PUBLIC_KEY" {}

# ec2-instance.tf
variable "INSTANCE_TYPE" {}
variable "INSTANCE_COUNT" {}
variable "AMIS" {
  description = "AMIs by region"
  type        = map(string)
  default = {
    # us-east-1 : Amazon Linux 2 AMI (HVM), SSD Volume Type
    us-east-1 = "ami-09d95fab7fff3776c"
    us-east-2 = "ami-06b94666"
  }
}

# vpc.tf
variable "VPC_CIDR" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "ENVIRONMENT_TAG" {}
variable "PUBLIC_SUBNETS_CIDR" {
  description = "CIDR block for the Public Subnet"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "SUBNETS_AZ" {
  description = "Availability zone to create subnet"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
variable "PRIVATE_SUBNETS_CIDR" {
  description = "CIDR block for the Private Subnet"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

# nacl.tf
variable "DESTINATION_CIDR_BLOCK" {
  type    = string
  default = "0.0.0.0/0"
}
variable "INGRESS_CIDR_BLOCK" {
  type    = list
  default = ["0.0.0.0/0"]
}
variable "EGRESS_CIDR_BLOCK" {
  type    = list
  default = ["0.0.0.0/0"]
}