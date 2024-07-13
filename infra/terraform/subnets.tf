data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.default.id
  count                   = 2
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, 2 + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index] # "ap-southeast-2a"

  tags = {
    Name  = "${var.service_name}-public-subnet${count.index}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name  = "${var.service_name}-rt-public1"
  }
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_main_route_table_association" "public_main" {
  vpc_id         = aws_vpc.default.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat_gateway" {
  count   = 2
  domain  = "vpc"

  tags = {
    name  = "${var.service_name}-eip-${count.index}"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = 2
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.nat_gateway.*.id, count.index)

  tags = {
    Name  = "${var.service_name}-ngw-${count.index}"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  count                   = 2
  availability_zone       = data.aws_availability_zones.available.names[count.index] # "ap-southeast-2b"

  tags = {
    Name  = "${var.service_name}-private-subnet${count.index}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.default.id
  count  = 2

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gateway.*.id, count.index)
  }

  tags = {
    Name  = "${var.service_name}-rt-private${count.index}"
  }
}

resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
