resource "aws_route_table" "public_subnet_rt" {
  vpc_id = aws_vpc.name.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_rt" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_subnet_rt.id

}

resource "aws_route_table" "private_subnet_rt" {
  vpc_id = aws_vpc.name.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgtw.id
  }

  tags = {
    Name = "Private-rt"
  }
}

resource "aws_route_table_association" "priate_rt" {
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_subnet_rt.id
  count          = length(aws_subnet.private)
}

resource "aws_route_table" "DB_subnet_rt" {
  vpc_id = aws_vpc.name.id


  tags = {
    Name = "DB-rt"
  }
}

resource "aws_route_table_association" "DB_rt" {
  route_table_id = aws_route_table.DB_subnet_rt.id
  count          = length(aws_subnet.private_db)
  subnet_id      = aws_subnet.private_db[count.index].id
}