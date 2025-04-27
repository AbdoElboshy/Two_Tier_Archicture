
provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "web1" {
ami                    = "ami-0cbf5e746b95ddc88"
instance_type          = "t2.micro"
subnet_id              = aws_subnet.public1.id
vpc_security_group_ids = [aws_security_group.web.id]
key_name               = "my-key"
user_data              = <<-EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
EOF


tags = {
Name = "web1"
}
}


resource "aws_instance" "web2" {
ami                    = "ami-0cbf5e746b95ddc88"
instance_type          = "t2.micro"
subnet_id              = aws_subnet.public2.id
vpc_security_group_ids = [aws_security_group.web.id]
key_name               = "my-key"
user_data              = <<-EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
EOF


tags = {
Name = "web2"
}
}


resource "aws_security_group" "web" {
name        = "web"
description = "Allow HTTP traffic"
vpc_id      = aws_vpc.vpc22.id


ingress {
from_port   = 80
to_port     = 80
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
}
