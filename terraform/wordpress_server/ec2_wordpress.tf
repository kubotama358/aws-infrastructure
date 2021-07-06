#####################################
# EC2 Instance
#####################################
resource "aws_instance" "wordpress_server" {
  ami                         = var.wordpress_server_ami_id
  instance_type               = var.wordpress_server_instance_type
  iam_instance_profile        = var.wordpress_server_iam_instance_profile
  key_name                    = var.wordpress_server_key_name
  vpc_security_group_ids = [
    aws_security_group.wordpress_server_sg.id,
  ]
  subnet_id  = data.terraform_remote_state.remote_state_common_network.outputs.common_public_subnet_1a_id
  private_ip = var.wordpress_server_private_ip
  user_data  = data.template_file.wordpress-server_user-data.rendered

  tags = {
    Name             = "${var.env}_wordpress_server"
    env              = var.env
  }
}

data "template_file" "wordpress-server_user-data" {
  template = file("user-data/wordpress-server.sh")

  vars = {
    env = var.env
  }
}


#####################################
# EIP
#####################################
resource "aws_eip_association" "eip_operation_wordpress_association" {
  instance_id   = aws_instance.wordpress_server.id
  allocation_id = var.wordpress_server_eip_allocation_id
}
