resource "aws_vpc" "vpc_1" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name                                            = var.vpc_tag_name
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
}
