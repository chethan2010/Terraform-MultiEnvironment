
This module is developed for joindevops.com we are creating following resources.

*VPC
* internetgateway
* internet and vpc attachment
* public subnets
* private subnets
* database subnets
* NatGate way
* Elastic IP
* Public route table
* private route table
* Database route table 
* route table and subnets table Associtaion
* Routes in all tables
* peering if required for users
* Routes of peering  in requister and acceptor vpc

## INPUTS
* Project Name (Required): you should Mention Project Name data type is string
* Environment (Optional): Default value is Dev. Type is String
* Common tags (Optional):user should provide their tags related to their project. Type is Map
* VPC CIDR (Optional): Default value is 10.0.0.0/16. Type is string
* enable dns hostname(Optional):default value is true. Type is bool
* vpc _tags(Optional):default value is Empty. Type is String
* Igw_tags(Optional):default value is Empty.Type is String
* Public subnets CIDRS(Req): user has to provide two valide subnet cidrs
* public _Cidr(optional): default value is empty. type is string
* Private subnets CIDRS(Req): user has to provide two valide subnet cidrs
* private _Cidr(optional): default value is empty. type is string
* Database subnets CIDRS(Req): user has to provide two valide subnet cidrs
* database _Cidr(optional): default value is empty. type is string
* database _group_tags(optional): default value is empty. type is string
* public_route_table_tags(optional): default value is empty. type is string
* private_route_table_tags(optional): default value is empty. type is string
* database_route_table_tags(optional): default value is empty. type is string
* is_perring_Required(optional): default value is false. type is bool
* acceptor_vpc-id(optional): default value is empty. Default vpc id would be taken
* Vpc_peering_tags(optional):Default value is empty.type is map
## OUTPUTS
* vpc_id: VPC_ID
* public_Subnet_ids: Alist of 2 public subnet ids created
* private_Subnet_ids: Alist of 2 private subnet ids create
* databasae_Subnet_ids: Alist of 2 database subnet ids create
* database_group_ids: Alist of 2 public subnet ids create