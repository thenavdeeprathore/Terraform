#! /bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo chkconfig httpd on
echo "<h1>Hello, This page is hosted by Navdeep on AWS EC2 Linux Instance using Terraform.</h1>" > /var/www/html/index.html
