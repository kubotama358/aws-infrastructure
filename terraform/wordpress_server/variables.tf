#####################################
#Common Settings
#####################################
variable "env" {}
variable "account_id" {}
variable "region" {}
variable "profile_name" {}

#####################################
# EC2 Instance
#####################################
variable "wordpress_server_ami_id" {}
variable "wordpress_server_instance_type" {}
variable "wordpress_server_iam_instance_profile" {}
variable "wordpress_server_key_name" {}
variable "wordpress_server_private_ip" {}
variable "wordpress_server_eip_allocation_id" {}

#####################################
# SecurityGroup
#####################################
variable "wordpress_server_sg_cidrs" { type = list(string) }