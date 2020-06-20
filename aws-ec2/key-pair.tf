# Generate public and private key to create a new key-pair while launching an EC2 instance
# ssh-keygen -f navdeep-key
resource "aws_key_pair" "navdeep_key" {
  key_name   = "navdeep-ec2-key"
  public_key = var.PATH_TO_PUBLIC_KEY
}