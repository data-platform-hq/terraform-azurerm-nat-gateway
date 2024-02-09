output "id" {
  value       = azurerm_nat_gateway.this.id
  description = "Nat gateway id"
}

output "name" {
  value       = azurerm_nat_gateway.this.name
  description = "Nat gateway name"
}

output "public_ip_address" {
  value       = azurerm_public_ip.this.ip_address
  description = "Public ip address"
}
