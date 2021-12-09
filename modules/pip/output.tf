output "public_ip_address_id" {
  value = azurerm_public_ip.pip.*.id
}

output "public_ip_num" {
  value = azurerm_public_ip.pip.count
}

output "public_ip_name" {
  value = azurerm_public_ip.pip.name
}
