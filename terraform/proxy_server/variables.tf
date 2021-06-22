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
variable "proxy_server_ami_id" {}
variable "proxy_server_instance_type" {}
variable "proxy_server_iam_instance_profile" {}
variable "proxy_server_key_name" {}
variable "proxy_server_private_ip" {}
variable "proxy_server_eip_allocation_id" {}

#####################################
# SecurityGroup
#####################################
variable "proxy_server_sg_cidrs" { type = list(string) }