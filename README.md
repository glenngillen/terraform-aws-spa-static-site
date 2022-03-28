# Complete Single Page App (SPA)/Static Site setup for AWS

This module creates a private S3 bucket to deploy a static
site or SPA to, creates a CloudFront distribution to serve
content (increasing performance and reducing transfer cost),
and sets up the CloudFront Origin Access Identity so that
CloudFront can access the otherwise private bucket.