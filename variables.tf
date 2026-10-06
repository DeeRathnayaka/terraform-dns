variable "domain_name" {
  description = "The DigitalOcean DNS domain to manage"
  type        = string
}

variable "record_name" {
  description = "The DNS record hostname"
  type        = string
}

variable "record_value" {
  description = "The IPv4 address for the A record"
  type        = string

  validation {
    condition     = can(cidrhost("${var.record_value}/32", 0))
    error_message = "record_value must be a valid IPv4 address."
  }
}

variable "ttl" {
  description = "DNS record TTL in seconds"
  type        = number
  default     = 300

  validation {
    condition     = var.ttl >= 60
    error_message = "ttl must be at least 60 seconds."
  }
}
