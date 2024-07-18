
locals {

resources_name="${var.project-name}-${var.environement}"   
azs_names= slice(data.aws_availability_zones.available.names,0,2)

 }