resource "aws_vpc" "terra-git-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = { Name = "terraform-git-actions-vpc" 
  }
}