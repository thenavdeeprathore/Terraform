resource "aws_elb" "navdeep-elb" {
  # ELB nodes will have public IP addresses
  # ELB nodes will route traffic to the private IP address of your registered EC2 instances
  name = "navdeep-elb"

  # only one subnet can be defined for the ELB in an AZ
  # if you select another subnet in the same AZ, it wll replace the former one
  # you need one public subnet in each AZ where the internet facing ELB will be defined
  subnets         = aws_subnet.public_subnets.*.id

  # you must assign a security group to your ELB which will control traffic that can reach to your ELB front-end listeners
  security_groups = ["${aws_security_group.sg.id}"]

  # ELB --> Application, Network, Classic
  # ELB listener is a process that checks for connection request
  # at least one listener is required to accept traffic
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
	# range is 2-10, default is 10
    healthy_threshold   = 2
	# range is 2-10, default is 2
    unhealthy_threshold = 2
	# range is 2-60 seconds, default is 5 seconds
    timeout             = 3
    target              = "HTTP:80/index.html"
	# range is 5-300 seconds, default is 30 seconds
    interval            = 30
  }

  # target group is logical grouping of EC2 instances
  # target group can be associated with auto-scaling group
  # target group can contain upto max 200 targets (200 EC2 instances)
  instances                   = aws_instance.webservers.*.id
  # By default cross_zone_load_balancing is disable, this equally distributes load across instances in the AZ
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "navdeep elb"
  }
}

# ELB should always be accesed using DNS and not IP
output "elb-dns-name" {
  description = "ELB DNS name"
  value       = "${aws_elb.navdeep-elb.dns_name}"
}
