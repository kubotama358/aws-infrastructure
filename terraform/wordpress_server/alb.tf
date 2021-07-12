#####################################
# Application Road Barancer
#####################################
resource "aws_lb" "wordpress_alb" {
  name               = "wordpress-alb"
  internal           = false
  load_balancer_type = "application"
  subnets = [data.terraform_remote_state.remote_state_common_network.outputs.common_public_subnet_1a_id,
  data.terraform_remote_state.remote_state_common_network.outputs.common_public_subnet_1c_id]
  security_groups = [aws_security_group.wordpress_server_sg.id]
}

resource "aws_lb_target_group" "wordpress_alb_target_group" {
  name     = "wordpress-alb-tg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.remote_state_common_network.outputs.common_vpc_id
}

resource "aws_lb_target_group_attachment" "wordpress_alb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.wordpress_alb_target_group.arn
  target_id        = aws_instance.wordpress_server.id
  port             = "80"
}

resource "aws_lb_listener" "wordpressalb_listener" {
  load_balancer_arn = aws_lb.wordpress_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.acm_certificate.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_alb_target_group.arn
  }
}