resource "aws_vpc" "terra-git-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = { Name = "terraform-git-actions-vpc" 
  }
}

resource "aws_subnet" "public-subnet"{
    vpc_id = aws_vpc.terra-git-vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true

    tags = {
        Name = "Public Subnet for Git Actions Project"
    }
}

resource "aws_internet_gateway" "pub-sub-gw" {
  vpc_id = aws_vpc.terra-git-vpc.id
}

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.terra-git-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pub-sub-gw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.pub-rt.id
}

resource "aws_security_group" "ssh" {
  name        = "allow_ssh"
  description = "Allow SSH"
  vpc_id      = aws_vpc.terra-git-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}