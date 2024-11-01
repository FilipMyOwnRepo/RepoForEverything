resource "vpc" "custom_vpc" {
  cidr_block = "10.0.0.0/16"
  name_vpc   = local.name_vpc
}

resource "subnet" "custom_subnet" {
  vpc_id     = vpc.custom_vpc.id
  cidr_block = "10.0.1.0/24"
  #availability_zone = "..."
  map_public_ip_on_launch = true #za assign public adresa
}

resource "internet_gateway" "igw" { #enable approach internet
  vpc_id   = aws_vpc.custom_vpc.id 
  name_igw = local.name_igw
}

resource "route_table" "route_table" { #route towards internet
  vpc_id = vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = internet_gateway.igw.id
  }
  router_table = local.router_table
}

resource "route_table_association" "public_association" { 
  subnet_id      = subnet.custom_subnet.id
  route_table_id = route_table.public_route_table.id
}

