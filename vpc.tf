
provider "aws" {
  region = "us-east-1"
  alias  = "vpc-alias"
}

resource "aws_vpc" "vpc22" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public1" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.vpc22.id
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "public2" {
  cidr_block              = "10.0.2.0/24"
  vpc_id                  = aws_vpc.vpc22.id
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public2"
  }
}

resource "aws_subnet" "private1" {
  cidr_block        = "10.0.3.0/24"
  vpc_id            = aws_vpc.vpc22.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "private1"
  }
}

resource "aws_subnet" "private2" {
  cidr_block        = "10.0.4.0/24"
  vpc_id            = aws_vpc.vpc22.id
  availability_zone = "us-east-1b"
  tags = {
    Name = "private2"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc22.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc22.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.vpc22.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vpc22.id
  }

  tags = {
    Name = "private1"
  }
}

resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.vpc22.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vpc22.id
  }

  tags = {
    Name = "private2"
  }
}

resource "aws_internet_gateway" "vpc22" {
  vpc_id = aws_vpc.vpc22.id

  tags = {
    Name = "vpc22"
  }
}

resource "aws_nat_gateway" "vpc22" {
  allocation_id = aws_eip.vpc22.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "vpc22"
  }
}

resource "aws_eip" "vpc22" {
  vpc = true
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private1.id
}
  
