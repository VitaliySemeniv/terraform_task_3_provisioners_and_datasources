output "public_ip" {
  value = data.azurerm_public_ip.pip.ip_address
}
