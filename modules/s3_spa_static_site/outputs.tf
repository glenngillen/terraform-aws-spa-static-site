output "cloudfront_access_identity_path" {
    value = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
}

output "s3_bucket_regional_name" {
    value = aws_s3_bucket.this.bucket_regional_domain_name
}

output "bucket_name" {
    value = aws_s3_bucket.this.bucket
}