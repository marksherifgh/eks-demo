variable "vpc_cidr_block" {
  description = "CIDR block for vpc"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_tag_name" {
  description = "Name of vpc"
  type        = string
  default     = "vpc_1"
}

variable "eks_cluster_name" {
  description = "Name of EKS cluster"
  type        = string
  default     = "eks-demo"
}

variable "az" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1a", "eu-west-1b"]
}

variable "private_subnet_cidr_block_1" {
  description = "CIDR block for private subnet 1"
  type        = string
  default     = "10.0.0.0/19"
}
variable "private_subnet_cidr_block_2" {
  description = "CIDR block for private subnet 2"
  type        = string
  default     = "10.0.32.0/19"
}

variable "public_subnet_cidr_block_1" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.0.64.0/19"
}

variable "public_subnet_cidr_block_2" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.96.0/19"
}

variable "private_subnet_tag_name_1" {
  description = "Name of private subnet 1"
  type        = string
  default     = "private-eu-west-1a"
}

variable "private_subnet_tag_name_2" {
  description = "Name of private subnet 2"
  type        = string
  default     = "private-eu-west-1b"
}

variable "public_subnet_tag_name_1" {
  description = "Name of public subnet"
  type        = string
  default     = "public-eu-west-1a"
}

variable "public_subnet_tag_name_2" {
  description = "Name of public subnet"
  type        = string
  default     = "public-eu-west-1b"
}

variable "eks_cluster_version" {
  description = "Version of eks cluster"
  type        = string
  default     = "1.28"
}