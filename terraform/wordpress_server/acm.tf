resource "aws_acm_certificate" "acm_certificate" {
  domain_name               = "maze555.com"
  subject_alternative_names = ["*.maze555.com"]
  validation_method         = "DNS"
  tags = {
    Name = "maze555.com"
  }
}