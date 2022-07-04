variable "infra_env" {
  default = "eng114_florent"
  description = "eng114_florent"
}

variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_numbers" {
  type        = map(number)
  description = "Map of AZ to a number that should be used for public subnets"
  default = {
    "eu-west-1a" = 1
    "eu-west-1b" = 2
    "eu-west-1c" = 3
  }
}

variable "private_subnet_numbers" {
  type        = map(number)
  description = "Map of AZ to a number that should be used for private subnets"
  default = {
    "eu-west-1a" = 4
    "eu-west-1b" = 5
    "eu-west-1c" = 6
  }
}

variable "node_ami_id" {
  default = "ami-065fdae15c0137971"
}

variable "db_ami_id" {
  default = "ami-0d6a76c5ccd771a19"
}

variable "aws_key" {
  default = "eng114_florent_jr"
}

variable "ubuntu_ami" {
  default = "ami-07b63aa1cfd3bc3a5"
}
