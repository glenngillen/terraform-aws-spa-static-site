variable "domain" {
    type = string
}
variable "domain_aliases" {
    type = list(string)
}
variable "certificate_arn" {
    type = string
}
