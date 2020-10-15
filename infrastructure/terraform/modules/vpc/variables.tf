
variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
}

variable "enable_dns_support" {}

variable "enable_dns_hostnames" {}

variable "public_subnet_az_1_cidr" {
    description = "CIDR for the Public Subnet"
}

variable "public_subnet_az_2_cidr" {
    description = "CIDR for the Public Subnet"
}

variable "private_subnet_az_1_cidr" {
    description = "CIDR for the Private Subnet"
}

variable "private_subnet_az_2_cidr" {
    description = "CIDR for the Private Subnet"
}

variable "aws_key_name" {
    description = "Kay pair name"
}

variable "ins_ami" {}

variable "project_name" {
  default = "smartpension-test"
}

variable "allow_all_cidr" {
  default = "0.0.0.0/0"
}

variable "az_1" {
  default = "eu-west-1a"
}

variable "az_2" {
  default = "eu-west-1b"
}

