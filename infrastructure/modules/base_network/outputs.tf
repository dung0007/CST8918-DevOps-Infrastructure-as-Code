output "virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}

output "test_subnet_id" {
  value = azurerm_subnet.test.id
}

output "prod_subnet_id" {
  value = azurerm_subnet.prod.id
}

output "dev_subnet_id" {
  value = azurerm_subnet.dev.id
}
output "admin_subnet_id" {
  value = azurerm_subnet.admin.id
}