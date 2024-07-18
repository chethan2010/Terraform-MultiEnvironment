module "vpc"{
 source = "../terraform-vpc"
 project-name = var.projectname
 common_tags = var.common_tags
 public_subnet_cidrs =var.public_subnet_cidrs
 private_subnet_cidrs = var.privat_subnet_cidrs
database_subnet_cidrs = var.database_subnet_cidrs
is_peering_required = var.is_peering_required
}
  
