module "vpc"{
 source = "../terraform-vpc"
 #source = "git::https://github.com/chethan2010/Terraform-MultiEnvironment/tree/main/terraform-vpc.git?ref=main"
 project-name = var.projectname
 common_tags = var.common_tags
 public_subnet_cidrs =var.public_subnet_cidrs
 private_subnet_cidrs = var.privat_subnet_cidrs
database_subnet_cidrs = var.database_subnet_cidrs
is_peering_required = var.is_peering_required
}
  
