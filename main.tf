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