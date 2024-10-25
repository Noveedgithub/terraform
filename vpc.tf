# VPC
resource "aws_vpc" "tf_vpc" {
    cidr_block = "10.10.0.0/20"
    enable_dns_hostnames = true
}

# Subnet 1
resource "aws_subnet" "tf_sn1" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.10.0.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true
}

# Subnet 2
resource "aws_subnet" "tf_sn2" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.10.1.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true
}

# VPC Security Group
resource  "aws_security_group" "vpc_sg" {
  name = "vpc_sg"
  description = "vpc_security_group"
  vpc_id = aws_vpc.tf_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
      }
  egress {
    from_port = 0
    to_port = 0 
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    }
}

# Internet Gateway
resource "aws_internet_gateway" "vpc_gw" {
  vpc_id = aws_vpc.tf_vpc.id
}

# Route table
resource "aws_route_table" "vpc_rt" {
  vpc_id = aws_vpc.tf_vpc.id
}

# Route
resource "aws_route" "vpc_r" {
  route_table_id            = aws_route_table.vpc_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.vpc_gw.id
}

# Route table association
resource "aws_route_table_association" "vpc_rta" {
  subnet_id      = aws_subnet.tf_sn1.id
  route_table_id = aws_route_table.vpc_rt.id
}

# 2nd Route table association
resource "aws_route_table_association" "vpc_rta_2" {
  subnet_id      = aws_subnet.tf_sn2.id
  route_table_id = aws_route_table.vpc_rt.id
}

# EC2 Instance
resource "aws_instance" "vpc_lab" {
   ami           = var.ami
   instance_type = var.instance_type
   key_name = "tfkp"
   vpc_security_group_ids = [aws_security_group.vpc_sg.id]
   depends_on = [aws_key_pair.tfkp]
   subnet_id   = aws_subnet.tf_sn2.id

tags = {
    Name = "VPC LAB INSTANCE"
  }
}
