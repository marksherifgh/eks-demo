resource "aws_subnet" "private_eu_west_1a" {
  vpc_id            = aws_vpc.vpc_1.id
  cidr_block        = var.private_subnet_cidr_block_1
  availability_zone = var.az[0]

  tags = {
    "Name"                            = var.private_subnet_tag_name_1
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/eks-demo"      = "owned"
  }
}

resource "aws_subnet" "private_eu_west_1b" {
  vpc_id            = aws_vpc.vpc_1.id
  cidr_block        = var.private_subnet_cidr_block_2
  availability_zone = var.az[1]

  tags = {
    "Name"                            = "private-us-east-1b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/eks-demo"      = "owned"
  }
}

resource "aws_subnet" "public_eu_west_1a" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.public_subnet_cidr_block_1
  availability_zone       = var.az[2]
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = var.public_subnet_tag_name_1
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/eks-demo" = "owned"
  }
}

resource "aws_subnet" "public_eu_west_1b" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.public_subnet_cidr_block_2
  availability_zone       = var.az[3]
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = var.public_subnet_tag_name_2
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/eks-demo" = "owned"
  }
}