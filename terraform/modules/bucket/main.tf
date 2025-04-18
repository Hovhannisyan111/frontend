resource "aws_s3_bucket" "frontend" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket                  = aws_s3_bucket.frontend.id
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.frontend.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = ["s3:GetObject"],
        Resource  = ["${aws_s3_bucket.frontend.arn}/*"]
      }
    ]
  })
  depends_on = [aws_s3_bucket_public_access_block.frontend]
}

#resource "aws_s3_object" "frontend_index" {
#  bucket = aws_s3_bucket.frontend.bucket
#  key    = var.index_key
#  source = var.index_path
#
#  depends_on = [aws_s3_bucket.frontend]
#
#}
