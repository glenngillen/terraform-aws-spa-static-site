output "s3_bucket_regional_name" {
    value = module.bucket.s3_bucket_regional_name
}

output "bucket_name" {
    value = module.bucket.bucket_name
}

output "cloudfront_domain" {
    value = module.cdn.cloudfront_domain
}

output "cloudfront_hosted_zone_id" {
  value = module.cdn.cloudfront_hosted_zone_id
}