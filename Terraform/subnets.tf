resource "aws_subnet" "public" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.name.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.name.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index + 2)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "Private subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_db" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.name.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index + 4)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "private db subnet ${count.index + 1}"
  }
}
