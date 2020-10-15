
module "vpc" {
  source = "./modules/vpc"
  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  private_subnet_az_1_cidr = var.private_subnet_az_1_cidr
  private_subnet_az_2_cidr = var.private_subnet_az_2_cidr
  public_subnet_az_1_cidr = var.public_subnet_az_1_cidr
  public_subnet_az_2_cidr = var.public_subnet_az_2_cidr
  ins_ami = var.ins_ami
  aws_key_name = var.aws_key_name
}
module "rds" {
  source = "./modules/rds"
  db_subnet_group_name = module.vpc.db_subnet_group_name
  db_password = var.db_password
  vpc_id = module.vpc.vpc_id
  public_subnet_cidr = var.public_subnet_az_1_cidr
}
