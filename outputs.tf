output "s3_bucket_regional_name" {
    value = module.bucket.s3_bucket_regional_name
}

output "bucket_name" {
    value = module.bucket.bucket_name
}

output "cloudfront_domain" {
    value = module.cdn.cloudfront_domain
}