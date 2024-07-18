# project varaibales
variable "project-name" {
  type = string
}

variable "environement" {

  type = string
  default="dev"

}

variable "common_tags" {
  type = map
  
}

#vpc variables
variable "vpc_cidr" {
    type=string
     default = "10.0.0.0/16"
}

variable "dns_name" {
    type = bool
    default = true
  
}

variable "vpc_tags" {
  type=map
  default = {

  }
}

#igw

variable "igw_tags" {
  type=map
  default = {}
  }
  
#subnets

variable "public_subnet_cidrs" {
  type = list
  validation {
       condition = length(var.public_subnet_cidrs)==2
       error_message = "Please Provide  2 valid public CIDR"
  }  
}

variable "public_subnet_cidr_tags" {
  type = map
  default ={} 
}


#private subnet

variable "private_subnet_cidrs" {
  type=list
  validation {
    condition = length(var.private_subnet_cidrs)==2
    error_message = "Please Provide 2 vaild Private CIDR"
  }
}
variable "private_subnet_cidr_tags" {
  type = map
  default ={} 
}



#Database subnet

variable "database_subnet_cidrs" {
  type=list
  validation {
    condition = length(var.database_subnet_cidrs)==2
    error_message = "Please Provide 1 vaild database CIDR"
  }
}
variable "database_subnet_cidr_tags" {
  type = map
  default ={} 
}

variable "database_subnet_group_tags" {
    type = map
    default = {}
}

#Natgate way

variable "nat_gateway_tags" {
    type = map
    default = {}
}

#Routetable

variable "public_route_table" {
  type = map
  default = {}
}

variable "private_route_table" {
  type = map
  default = {}
}

variable "database_route_table" {
  type = map
  default = {}
}

#vpc peering
variable "is_peering_required" {
      type=bool 
      default = false 
}

variable "acceptor_vpc_id" {
  type=string
  default = ""
  
}

variable "vpc_perring_tags" {
  type=map
  default = {}
}


