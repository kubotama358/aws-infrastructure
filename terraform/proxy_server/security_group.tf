#####################################
# SecurityGroup
#####################################
resource "aws_security_group" "proxy_server_sg" {
  count       = "${var.env == "dev" ? 1 : 0}"
  name        = "proxy_server_sg"
  description = "proxy_server_sg"
  vpc_id      = data.terraform_remote_state.remote_state_common_network.outputs.common_vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = var.proxy_server_sg_cidrs
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "proxy_server_sg"
  }
}
