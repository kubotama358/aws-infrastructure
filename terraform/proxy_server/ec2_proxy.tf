#####################################
# EC2 Instance
#####################################
resource "aws_instance" "proxy_server" {
  count                       = "${var.env == "dev" ? 1 : 0}"
  ami                         = var.proxy_server_ami_id
  instance_type               = var.proxy_server_instance_type
  iam_instance_profile        = var.proxy_server_iam_instance_profile
  key_name                    = var.proxy_server_key_name
  vpc_security_group_ids = [
    aws_security_group.proxy_server_sg[count.index].id,
  ]
  subnet_id  = data.terraform_remote_state.remote_state_common_network.outputs.common_public_subnet_1a_id
  private_ip = var.proxy_server_private_ip
  user_data  = data.template_file.proxy-server_user-data.rendered

  tags = {
    Name             = "${var.env}_proxy_server"
    env              = var.env
  }
}

data "template_file" "proxy-server_user-data" {
  template = file("user-data/proxy-server.sh")

  vars = {
    env = var.env
  }
}


#####################################
# EIP
#####################################
resource "aws_eip_association" "eip_operation_proxy_assoc" {
  count         = "${var.env == "dev" ? 1 : 0}"
  instance_id   = aws_instance.proxy_server[count.index].id
  allocation_id = var.proxy_server_eip_allocation_id
}