#####################################
# VPC
#####################################

resource "aws_vpc" "common_vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "common-vpc"
  }
}

#####################################
# IGW
#####################################

resource "aws_internet_gateway" "common_igw" {
  vpc_id = aws_vpc.common_vpc.id

  tags = {
    Name = "common-igw"
  }
}

#####################################
# NGW
#####################################
//resource "aws_nat_gateway" "common_natgateway" {
//  subnet_id     = aws_subnet.common_public_subnet_1a.id
//  allocation_id = var.common_nat_eip_allocation_id
//  tags = {
//    Name = "common-natgateway"
//  }
//}

#####################################
# Subnet
#####################################

resource "aws_subnet" "common_public_subnet_1a" {
  vpc_id                  = aws_vpc.common_vpc.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "common-public-subnet-1a"
  }
}

resource "aws_subnet" "common_public_subnet_1c" {
  vpc_id                  = aws_vpc.common_vpc.id
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true

  tags = {
    Name = "common-public-subnet-1c"
  }
}

//resource "aws_subnet" "common_private_subnet_1a" {
//  vpc_id                  = aws_vpc.common_vpc.id
//  cidr_block              = "10.1.3.0/24"
//  availability_zone       = "${var.region}a"
//  map_public_ip_on_launch = false
//
//  tags = {
//    Name = "common-private-subnet-1a"
//  }
//}
//
//resource "aws_subnet" "common_private_subnet_1c" {
//  vpc_id                  = aws_vpc.common_vpc.id
//  cidr_block              = "10.1.4.0/24"
//  availability_zone       = "${var.region}c"
//  map_public_ip_on_launch = false
//
//  tags = {
//    Name = "common-private-subnet-1c"
//  }
//}

#####################################
# RouteTable
#####################################

//resource "aws_route_table" "common_private_route" {
//  vpc_id = aws_vpc.common_vpc.id
//
//  route {
//    cidr_block     = "0.0.0.0/0"
//    nat_gateway_id = aws_nat_gateway.common_natgateway.id
//  }
//
//  tags = {
//    Name = "common-private-route"
//  }
//}

resource "aws_route_table" "common_public_route" {
  vpc_id = aws_vpc.common_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.common_igw.id
  }

  tags = {
    Name = "common-public-route"
  }
}

#####################################
# RouteTable Association
#####################################

resource "aws_route_table_association" "common_public_subnet_1a" {
  route_table_id = aws_route_table.common_public_route.id
  subnet_id      = aws_subnet.common_public_subnet_1a.id
}

resource "aws_route_table_association" "common_public_subnet_1c" {
  route_table_id = aws_route_table.common_public_route.id
  subnet_id      = aws_subnet.common_public_subnet_1c.id
}

//resource "aws_route_table_association" "common_private_subnet_1a" {
//  route_table_id = aws_route_table.common_private_route.id
//  subnet_id      = aws_subnet.common_private_subnet_1a.id
//}
//
//resource "aws_route_table_association" "common_private_subnet_1c" {
//  route_table_id = aws_route_table.common_private_route.id
//  subnet_id      = aws_subnet.common_private_subnet_1c.id
//}
