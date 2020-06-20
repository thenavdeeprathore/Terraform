variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {}

variable "SSH_PUBLIC_KEY" {}

variable "INSTANCE_TYPE" {}

variable "INSTANCE_COUNT" {}

variable "INSTANCE_TAG" {}

variable "AMIS" {
  type = map(string)
  default = {
    # us-east-1 : Amazon Linux 2 AMI (HVM), SSD Volume Type
    us-east-1 = "ami-09d95fab7fff3776c"
    us-east-2 = "ami-06b94666"
  }
}

variable "VPC_CIDR" {
  default = "10.0.0.0/16"
}

variable "PUBLIC_SUBNETS_CIDR" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "SUBNETS_AZ" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "PRIVATE_SUBNETS_CIDR" {
  type    = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}
