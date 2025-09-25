resource "aws_security_group" "ssh" {
  name        = "SecGrp for Git Actions Project"
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

resource "aws_instance" "web" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (for us-east-1)
  instance_type = "t2.micro"

  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.ssh.id]
  associate_public_ip_address = true

  tags = {
    Name = "EC2 Instance for Git Actions Project"
  }
}