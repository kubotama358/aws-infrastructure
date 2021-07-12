#####################################
# Common Settings
#####################################
env          = "dev"
account_id   = "997221705915"
region       = "ap-northeast-1"
profile_name = "dev"

#####################################
# EC2 Instance
#####################################
wordpress_server_ami_id               = "ami-02c30d519ea301e1c"
wordpress_server_instance_type        = "t2.micro"
wordpress_server_iam_instance_profile = "ServerExecutionRole"
wordpress_server_key_name             = "dev_wordpress_server_keypair"
wordpress_server_private_ip           = "10.1.1.11"
wordpress_server_eip_allocation_id    = "eipalloc-0823ca483abb99666"

#####################################
# SecurityGroup
#####################################
wordpress_server_sg_cidrs = ["0.0.0.0/0"]