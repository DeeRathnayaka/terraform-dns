resource "digitalocean_record" "dns_record" {
  domain = var.domain_name
  type   = "A"
  name   = var.record_name
  value  = var.record_value
  ttl    = var.ttl
}

