output "s3_bucket_regional_name" {
    value = module.s3_spa_static_site.s3_bucket_regional_name
}

output "bucket_name" {
    value = module.s3_spa_static_site.bucket_name
}

output "cloudfront_domain" {
    value = module.cdn.cloudfront_domain
}