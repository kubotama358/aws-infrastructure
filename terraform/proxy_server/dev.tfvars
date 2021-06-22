#####################################
# Common Settings
#####################################
env = "dev"
account_id = "997221705915"
region = "ap-northeast-1"
profile_name = "dev"

#####################################
# EC2 Instance
#####################################
proxy_server_ami_id = "ami-020aa28a5ff5a4bf9"
proxy_server_instance_type = "t2.micro"
proxy_server_iam_instance_profile = ""
proxy_server_key_name = "dev_proxy_server_keypair"
proxy_server_private_ip = "172.10.0.5"
proxy_server_eip_allocation_id = "eipalloc-0823ca483abb99666"

#####################################
# SecurityGroup
#####################################
proxy_server_sg_cidrs = ["0.0.0.0/0"]