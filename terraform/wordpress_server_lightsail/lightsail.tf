resource "aws_lightsail_key_pair" "wordpress_key_pair" {
  name = "${var.env}_wordpress_server_lightsail_keypair"
}

resource "aws_lightsail_instance" "wordpress_instance" {
  name              = "wordpress"
  availability_zone = "ap-northeast-1a"
  blueprint_id      = "wordpress"
  bundle_id         = "micro_2_0"
  key_pair_name     = aws_lightsail_key_pair.wordpress_key_pair.name
}

resource "aws_lightsail_static_ip" "wordpress_static_ip" {
  name = "wordpress_ip"
}

resource "aws_lightsail_static_ip_attachment" "wordpress" {
  static_ip_name = aws_lightsail_static_ip.wordpress_static_ip.id
  instance_name  = aws_lightsail_instance.wordpress_instance.id
}