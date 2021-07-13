output "common_vpc_id" {
  value = aws_vpc.common_vpc.id
}

output "common_public_subnet_1a_id" {
  value = aws_subnet.common_public_subnet_1a.id
}

output "common_public_subnet_1c_id" {
  value = aws_subnet.common_public_subnet_1c.id
}

//output "common_private_subnet_1a_id" {
//  value = aws_subnet.common_private_subnet_1a.id
//}
//
//output "common_private_subnet_1c_id" {
//  value = aws_subnet.common_private_subnet_1c.id
//}

output "common_public_subnet_1a_cidr" {
  value = aws_subnet.common_public_subnet_1a.cidr_block
}

output "common_public_subnet_1c_cidr" {
  value = aws_subnet.common_public_subnet_1c.cidr_block
}

//output "common_private_subnet_1a_cidr" {
//  value = aws_subnet.common_private_subnet_1a.cidr_block
//}
//
//output "common_private_subnet_1c_cidr" {
//  value = aws_subnet.common_private_subnet_1c.cidr_block
//}

output "maze555_route53_zone_id" {
  value = aws_route53_zone.maze555_route53_zone.zone_id
}