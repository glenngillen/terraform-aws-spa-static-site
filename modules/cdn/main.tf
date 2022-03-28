data "aws_iam_policy_document" "glenngillen_cloudfront_oai_policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.glenngillen-dot-com.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.default.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.glenngillen-dot-com.arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.default.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "glenngillen_cloudfront_oai_policy" {
  bucket = aws_s3_bucket.glenngillen-dot-com.id
  policy = data.aws_iam_policy_document.glenngillen_cloudfront_oai_policy_document.json
}
resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = var.s3_bucket_regional_name
    origin_id   = "s3-website"

    s3_origin_config {
      origin_access_identity = var.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = var.domain_aliases

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-website"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = true
      headers = []
      cookies {
        forward = "none"
      }
    }

    min_ttl                = 3600
    default_ttl            = 604800
    max_ttl                = 604800
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.certificate_arn
    ssl_support_method = "sni-only"
  }
}