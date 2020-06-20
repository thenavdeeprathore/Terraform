# 1) Create EC2 instance
# 2) Create a key-pair
# 3) Add user-data with Apache server script
resource "aws_instance" "webserver" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  count         = var.INSTANCE_COUNT
  key_name      = aws_key_pair.navdeep_key.key_name
  user_data     = file("install-apache.sh")
  tags = {
    Name = "${var.INSTANCE_TAG}-${count.index + 1}"
  }
}

output "public_ip" {
  value = "${aws_instance.webserver.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.webserver.*.public_dns}"
}