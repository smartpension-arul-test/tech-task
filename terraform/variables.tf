variable "profile" {
    description = "AWS profile"
}

variable "aws_region" {
    default = "eu-west-1"
    description = "EC2 Region for the VPC"
}

variable "region_1_az_1" {
  default = "eu-west-1a"
}

variable "region_1_az_2" {
  default = "eu-west-1b"
}

variable "vpc_cidr" {
    type = string
}

variable "enable_dns_support" {
    type = string
}

variable "enable_dns_hostnames" {
    type = string
}

variable "ins_ami" {
    description = "AMIs by region"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
}

variable "public_subnet_cidr_2" {
    description = "CIDR for the Public Subnet"
}

variable "private_subnet_cidr_2" {
    description = "CIDR for the Private Subnet"
}

variable "email_address" {
    description = "Email Address"
}

variable "project_name" {}

variable "db_password" {}

variable "aws_key_name" {}

variable "machine_type" {}

variable "listen_port" {}

variable "protocol" {}

variable "ssl_arn" {}









