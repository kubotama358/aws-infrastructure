resource "aws_s3_bucket" "packer_keypair_bucket" {
  bucket = "${var.env}-packer-keypair-bucket"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

//resource "aws_s3_bucket_policy" "packer_keypair_bucket_policy" {
//  bucket = aws_s3_bucket.packer_keypair_bucket.id
//  policy = data.aws_iam_policy_document.walther_cs_front_query_results_policy_document.json
//}
//
//data "aws_iam_policy_document" "walther_cs_front_query_results_policy_document" {
//
//  statement {
//    sid = "IPAllow"
//    effect = "Deny"
//    principals {
//      type = "*"
//      identifiers = ["*"]
//    }
//    actions = ["s3:GetObject"]
//    resources = [
//      "arn:aws:s3:::${aws_s3_bucket.packer_keypair_bucket.id}/*"
//    ]
//    condition {
//      test = "NotIpAddress"
//      variable = "aws:sourceIp"
//      values = var.packer_keypair_bucket_allow_ips
//    }
//  }
//}