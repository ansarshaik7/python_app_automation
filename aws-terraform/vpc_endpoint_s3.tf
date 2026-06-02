resource "aws_vpc_endpoint" "s3" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.ap-south-1.s3"

  route_table_ids = concat(
    module.vpc.public_route_table_ids,
    module.vpc.private_route_table_ids
  )

  tags = {
    Name = "s3-endpoint"
  }
}

# bucket policy
resource "aws_s3_bucket_policy" "private_access" {
  bucket = module.s3_bucket.s3_bucket_id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowOnlyVPCEndpoint"
        Effect = "Allow"

        Principal = "*"

        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]

        Resource = [
          "${module.s3_bucket.s3_bucket_arn}/*"
        ]

        Condition = {
          StringEquals = {
            "aws:sourceVpce" = aws_vpc_endpoint.s3.id
          }
        }
      }
    ]
  })
}