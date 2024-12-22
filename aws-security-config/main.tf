
provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr     = var.vpc_cidr
  subnet_cidr  = var.subnet_cidr
  project_name = var.project_name
}

module "security" {
  source = "./modules/security"

  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.subnet_id
  allowed_cidr = "${var.my_ip}/32"
}

module "compute" {
  source = "./modules/compute"

  subnet_id         = module.vpc.subnet_id
  security_group_id = module.security.security_group_id
  instance_type     = var.instance_type
  key_name          = var.key_name
}
