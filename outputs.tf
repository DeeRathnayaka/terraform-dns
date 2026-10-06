output "dns_record_fqdn" {
  description = "The fully qualified domain name of the DNS record"
  value       = digitalocean_record.dns_record.fqdn
}

output "dns_record_id" {
  description = "The DigitalOcean DNS record ID"
  value       = digitalocean_record.dns_record.id
}
