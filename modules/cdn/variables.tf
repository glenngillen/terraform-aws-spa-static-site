variable "s3_bucket_regional_name" {
    type = string
}

variable "domain_aliases" {
    type = list(string)
}

variable "certificate_arn" {
    type = string
}

variable "cloudfront_access_identity_path" {
    type = string
}