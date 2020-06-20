#! /bin/bash
yum update -y
yum install httpd -y
service httpd start
chkconfig httpd on
echo "<h1>Hello, This page is hosted by Navdeep on AWS EC2 Linux Instance using Terraform.</h1>" > /var/www/html/index.html
