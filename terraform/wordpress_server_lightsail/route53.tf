resource "aws_route53_record" "wordpress_maze555_route53_record" {
  type    = "A"
  zone_id = data.terraform_remote_state.remote_state_common_network.outputs.maze555_route53_zone_id
  name    = "maze555.com"
  ttl     = "300"
  records = [aws_lightsail_static_ip.wordpress_static_ip.ip_address]
}