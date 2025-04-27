
provider "aws" {
  region = "us-east-1"
  alias  = "rds-alias"
}
resource "aws_db_subnet_group" "vpc22" {
name       = "vpc22"
subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]
}


resource "aws_db_instance" "vpc22" {
identifier             = "vpc22"
engine                 = "mysql"
instance_class         = "db.t2.micro"
allocated_storage      = 5
storage_type           = "gp2"
db_subnet_group_name   = aws_db_subnet_group.vpc22.name
vpc_security_group_ids = [aws_security_group.rds_sg.id]
db_name                = "vpc22"
username               = "admin"
password               = "mypassword"


tags = {
Name = "vpc22"
}
}


resource "aws_security_group" "rds_sg" {
name        = "rds_sg"
description = "Allow MySQL traffic"
vpc_id      = aws_vpc.vpc22.id


ingress {
from_port       = 3306
to_port         = 3306
protocol        = "tcp"
security_groups = [aws_security_group.web.id]
}
}
