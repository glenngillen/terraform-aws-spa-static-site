variable "domain" {
    type = string
}
variable "domain_aliases" {
    type = list(string)
}
variable "certificate_arn" {
    type = string
}

variable "logging_enabled" {
    type = bool
    default = false
}

variable "logging_config" {
    type = object({
      include_cookies = bool
      bucket          = string
      prefix          = string
    })
    default = null
}