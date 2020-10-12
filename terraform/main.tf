
module "vpc" {
  source = "./modules/vpc"
  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  private_subnet_cidr = var.private_subnet_cidr
  private_subnet_cidr_2 = var.private_subnet_cidr_2
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_cidr_2 = var.public_subnet_cidr_2
  ins_ami = var.ins_ami
  aws_key_name = var.aws_key_name

}

module "ec2" {
  source = "./modules/ec2"
  ins_ami = var.ins_ami
  az_zone = var.region_1_az_1
  instance_type = var.machine_type
  aws_key_name = var.aws_key_name
  public_subnet_id = module.vpc.public_subnet_id
  security_group_id = flatten(["${module.vpc.vpc_security_group_ids}"])
}

module "alb" {
  source = "./modules/alb"
  security-group-id = flatten(["${module.vpc.vpc_security_group_ids}"])
  subnet_id = module.vpc.subnet_ids
  listen_port = var.listen_port
  protocol = var.protocol
  vpc_id = module.vpc.vpc_id
  ssl_arn = var.ssl_arn
  
}

module "rds" {
  source = "./modules/rds"
  db_subnet_group_name = module.vpc.db_subnet_group_name
  vpc_security_group_ids = flatten(["${module.vpc.vpc_security_group_ids}"])
  db_password = var.db_password
}
