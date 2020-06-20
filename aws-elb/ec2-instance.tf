resource "aws_instance" "webservers" {
  ami             = var.AMIS[var.AWS_REGION]
  instance_type   = var.INSTANCE_TYPE
  count           = length(var.PUBLIC_SUBNETS_CIDR)
  subnet_id       = element(aws_subnet.public_subnets.*.id, count.index)
  security_groups = ["${aws_security_group.sg.id}"]
  user_data       = file("install_apache.sh")
  key_name        = aws_key_pair.navdeep_key.key_name
  tags = {
    Name = "${var.INSTANCE_TAG}-${count.index + 1}"
  }
}

output "ip" {
  description = "IP Address of webservers instances"
  value       = "${aws_instance.webservers.*.public_ip}"
}
