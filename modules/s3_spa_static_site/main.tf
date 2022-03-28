resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "OAI for s3 website access"
}

data "aws_iam_policy_document" "s3_website_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.s3_website_policy.json
}

resource "aws_s3_bucket" "this" {
    bucket = var.domain
    acl = "private"
    website {
        index_document = "index.html"
        error_document = "error.html"
    }
}