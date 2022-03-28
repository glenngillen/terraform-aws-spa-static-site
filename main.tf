module "bucket" {
    source  = "./modules/s3_spa_static_site"

    domain = var.domain
}

module "cdn" {
    source = "./modules/cdn"

    domain = var.domain
    domain_aliases = concat(var.domain, var.domain_aliases)
    certificate_arn = var.certificate_arn
}