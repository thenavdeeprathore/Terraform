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