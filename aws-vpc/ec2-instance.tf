# Define webserver inside the public subnet
resource "aws_instance" "webserver" {
  ami                    = var.AMIS[var.AWS_REGION]
  instance_type          = var.INSTANCE_TYPE
  count                  = var.INSTANCE_COUNT
  subnet_id              = element(aws_subnet.public_subnets.*.id, count.index)
  vpc_security_group_ids = ["${aws_security_group.sg_web.id}"]
  user_data              = file("install-apache.sh")
  key_name               = aws_key_pair.navdeep_key.key_name
  tags = {
    Name = "WebServer-${count.index + 1}"
  }
}

output "ec2_instances_public_ip" {
  value = "${aws_instance.webserver.*.public_ip}"
}

output "ec2_instances_public_dns" {
  value = "${aws_instance.webserver.*.public_dns}"
}

# Define database inside the private subnet
resource "aws_instance" "database" {
  ami                    = var.AMIS[var.AWS_REGION]
  instance_type          = var.INSTANCE_TYPE
  count                  = var.INSTANCE_COUNT
  subnet_id              = element(aws_subnet.private_subnets.*.id, count.index)
  vpc_security_group_ids = ["${aws_security_group.sg_db.id}"]
  key_name               = aws_key_pair.navdeep_key.key_name
  tags = {
    Name = "Database-${count.index + 1}"
  }
}

output "ec2_instances_private_ip" {
  value = "${aws_instance.database.*.private_ip}"
}

output "ec2_instances_private_dns" {
  value = "${aws_instance.database.*.private_dns}"
}
