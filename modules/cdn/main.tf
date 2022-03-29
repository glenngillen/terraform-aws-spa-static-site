terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }
}

resource "aws_cloudfront_distribution" "this" {
  dynamic "logging_config" {
    for_each = var.logging_enabled == true ? toset([var.logging_config]) : toset([])
    content {
      include_cookies = logging_config.include_cookies
      bucket          = logging_config.bucket
      prefix          = logging_config.prefix
    }
  }
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