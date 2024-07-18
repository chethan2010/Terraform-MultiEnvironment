resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support=true
  enable_dns_hostnames=var.dns_name

  tags = merge(
    var.common_tags,
    var.vpc_tags,
    {
      Name=local.resources_name
    }
  )

}

# Igw

resource "aws_internet_gateway" "Igw" {
  vpc_id = aws_vpc.main.id

  tags =merge(
    var.common_tags,
    var.igw_tags
  )
}

#subnet

resource "aws_subnet" "public" {    #first name is public of[0], second name is public[1]
  count=length(var.public_subnet_cidrs)
  map_public_ip_on_launch = true   
  availability_zone = local.azs_names[count.index]
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]

  tags = merge(
    var.common_tags,
    var.public_subnet_cidr_tags,
      {   
        Name="${local.resources_name}-public-${local.azs_names[count.index]}"

    }

  )

}


#Private subnet

resource "aws_subnet" "private" {
  count=length(var.private_subnet_cidrs)
  availability_zone = local.azs_names[count.index]
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]

  tags = merge(
    var.common_tags,
    var.private_subnet_cidr_tags,
      {   
        Name="${local.resources_name}-private-${local.azs_names[count.index]}"

    }

  )
}

#database subnet

resource "aws_subnet" "database" {
  count=length(var.database_subnet_cidrs)
  availability_zone = local.azs_names[count.index]
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidrs[count.index]

  tags = merge(
    var.common_tags,
    var.database_subnet_cidr_tags,
      {   
        Name="${local.resources_name}-database-${local.azs_names[count.index]}"

    }

  )
}

resource "aws_db_subnet_group" "default" {
  name       = "${local.resources_name}"
  subnet_ids = aws_subnet.database[*].id

  tags = merge(
    var.common_tags,
    var.database_subnet_group_tags,
    {
        Name = "${local.resources_name}"
    }
  )
}



resource "aws_eip" "nat" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.common_tags,
    var.nat_gateway_tags,
      {   
        Name="${local.resources_name}" #expense-dev

    }

  )
      depends_on = [aws_internet_gateway.Igw] #this is explict dependency
} 

#public route

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.public_route_table,
      {   
        Name="${local.resources_name}-public" #expense-dev-publlic

    }

  )
}
#Private route table

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.private_route_table,
      {   
        Name="${local.resources_name}-private" #expense-dev-private

    }

  )

}

#database
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.database_route_table,
      {   
        Name="${local.resources_name}-database" #expense-dev-database

    }

  )

}

#Public route table
resource "aws_route" "pubic_route" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.Igw.id

}

#Private route table
resource "aws_route" "Private_route_nat" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.nat.id
  
}

#database route table
resource "aws_route" "database_route_nat" {
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.nat.id
  
}


#Route table subnet associtaion

#Private routes
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "Private" {
  count = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private[*].id,count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidrs)
  subnet_id      = element(aws_subnet.database[*].id,count.index)
  route_table_id = aws_route_table.database.id
}

