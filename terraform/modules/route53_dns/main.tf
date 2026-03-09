# Get the hosted zone ID for the domain
data "aws_route53_zone" "selected" {
  name         = var.domain_name
  private_zone = false
}

# Create A records for each subdomain
resource "aws_route53_record" "vm_records" {
  for_each = toset(var.subdomains)

  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${each.value}.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [var.vm_ipv4_address]
}

# Optional: Add reverse DNS record
resource "hcloud_rdns" "vm_rdns" {
  count = length(var.subdomains) > 0 ? 1 : 0

  server_id  = var.vm_id
  ip_address = var.vm_ipv4_address
  dns_ptr    = "${var.subdomains[0]}.${var.domain_name}"
}

output "dns_records" {
  description = "Created DNS records"
  value = {
    for subdomain in var.subdomains :
    subdomain => "${subdomain}.${var.domain_name}"
  }
}