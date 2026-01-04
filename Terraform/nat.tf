resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "ElasticIP"
  }
}

resource "aws_nat_gateway" "natgtw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name = "Nat-gateway"
  }
}

